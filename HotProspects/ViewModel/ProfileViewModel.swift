//
//  ProfileViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import UIKit

extension ProfileView {
    @MainActor
    class ProfileViewModel: ObservableObject {
        let manager = ProspectManager.shared
        
        @Published var name = ""
        @Published var emailAddress = ""
        @Published var userExist = false
        @Published var user = [User]()
        @Published var showingAlert = false
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingDeleteProfileAlert = false
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        func createNewProfile() {
            Task {
                await manager.createNewProfile(name: name, emailAddress: emailAddress)
                getUser()
                name = ""
                emailAddress = ""
            }
        }
        
        func getUser() {
            Task {
                await manager.fetchUser()
                user = await manager.user
                if !user.isEmpty {
                    self.userExist = true
                } else {
                    self.userExist = false
                }
            }
        }
        
        func qrcodeGenerator() -> UIImage? {
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
        
        func saveQRCode() {
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
            Task {
                await manager.deleteUser()
                getUser()
            }
        }
        
        init() {
            getUser()
        }
    }
}
