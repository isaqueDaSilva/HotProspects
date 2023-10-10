//
//  ProspectViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

extension ProspectsView {
    class ProspectViewModel: ObservableObject {
        let manager = ProspectManager.shared
        @Published var people = [Prospects]()
        @Published var filterTypeView: FilterTypesViews
        
        var filterProspects: [Prospects] {
            switch filterTypeView {
            case .everyone:
                return people
            case .contacteds:
                return people.filter { $0.isContacted }
            case .uncontacted:
                return people.filter { !$0.isContacted }
            }
        }
        
        func getPeoples() {
            Task {
                self.people = await manager.prospects
            }
        }
        
        init(filterType: FilterTypesViews) {
            self.filterTypeView = filterType
            
            getPeoples()
        }
    }
}
