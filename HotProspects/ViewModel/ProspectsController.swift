//
//  ProspectsController.swift
//  HotProspects
//
//  Created by Isaque da Silva on 12/10/23.
//

import CodeScanner
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UserNotifications

class ProspectsController: ObservableObject {
    let manager = ProspectManager()
    
    let prospectsViews = [
        ProspectType(type: .everyone, icone: "person.3"),
        ProspectType(type: .contacteds, icone: "checkmark.circle"),
        ProspectType(type: .uncontacted, icone: "questionmark.diamond")
    ]
    
    
    @MainActor @Published var user = [User]()
    @AppStorage("SortedBy") var sortedBy: SortedBy = .increasing
    @Published var profileViewState: ProfileViewState = .createProfile
    @Published var showingDeleteProfileAlert = false
    @Published var name = ""
    @Published var emailAddress = ""
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isScannerViewOn = false
    @Published var showingErrorAlert = false
 
    func getUser() {
        Task { @MainActor in
            await manager.fetchUser()
            user = await manager.user
            if !user.isEmpty {
                self.profileViewState = .profileCreated
            } else {
                self.profileViewState = .createProfile
            }
        }
    }
    
    func createNewProfile() {
        Task { @MainActor in
            await manager.createNewProfile(name: name, emailAddress: emailAddress)
            getUser()
            name = ""
            emailAddress = ""
        }
    }
    
    @MainActor func qrcodeGenerator() -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        guard let userIndex = user.first else { return nil }
        
        let string = "\(userIndex.wrappedName)\n\(userIndex.wrappedEmailAddress)"
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    @MainActor func saveQRCode() {
        guard let qrCode = qrcodeGenerator() else { return }
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            self.alertTitle = "Saved"
            self.alertMessage = "Your QR Code has been saved successfully!"
            self.showingAlert = true
        }
        
        imageSaver.errorHandler = {
            self.alertTitle = "Error"
            self.alertMessage = "An error occurred while saving the QR Code to the gallery.\($0.localizedDescription)\nPlease try again!"
            self.showingAlert = true
        }
        
        imageSaver.writeToPhotoAlbum(qrCode)
    }
    
    func deleteUser() {
        Task { @MainActor in 
            await manager.deleteUser()
            getUser()
        }
    }
    
    func isShowingScannerValid() {
        Task { @MainActor in
            if await manager.user.isEmpty {
                showingErrorAlert = true
            } else {
                isScannerViewOn = true
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isScannerViewOn = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            Task { @MainActor in
                await manager.addNewProspect(name: details[0],emailAddress: details[1])
                getUser()
            }
        case .failure(let error):
            print("Scanning falied. Error: \(error.localizedDescription)")
        }
    }
    
    func toggleIsContacted(_ prospect: Prospect) {
        Task { @MainActor in
            await manager.toggleIsContactedStatus(prospect)
            getUser()
        }
    }
    
    @MainActor func addNotifications(for prospect: Prospect) {
        guard let user = user.first else { return }
        guard let prospect = user.prospectList.first else { return }
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "\(user.wrappedName), contact \(prospect.wrappedName)"
            content.body = prospect.wrappedEmailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponent = DateComponents()
            dateComponent.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Use of the notification center not authorized by the user.")
                    }
                }
            }
        }
    }
    
    init() {
        getUser()
    }
}
