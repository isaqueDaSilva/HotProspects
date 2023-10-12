//
//  ProspectViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import CodeScanner
import Foundation

extension ProspectsView {
    class ProspectViewModel: ObservableObject {
        let manager = ProspectManager.shared
        
        @Published var peoples = [Prospect]()
        @Published var filterTypeView: FilterTypesViews
        @Published var isScannerViewOn = false
        @Published var showingErrorAlert = false
        
        var filterProspects: [Prospect] {
            switch filterTypeView {
            case .everyone:
                return peoples
            case .contacteds:
                return peoples.filter { $0.isContacted }
            case .uncontacted:
                return peoples.filter { !$0.isContacted }
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
        
        func getPeoples() {
            Task { @MainActor in
                await manager.fetchUser()
                peoples = await manager.prospectList
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
                    getPeoples()
                }
            case .failure(let error):
                print("Scanning falied. Error: \(error.localizedDescription)")
            }
        }
        
        func toggleIsContacted(_ prospect: Prospect) {
            Task { @MainActor in
                await manager.toggleIsContactedStatus(prospect)
                getPeoples()
            }
        }
        
        init(filterType: FilterTypesViews) {
            self.filterTypeView = filterType
        }
    }
}
