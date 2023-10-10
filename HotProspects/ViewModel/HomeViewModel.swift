//
//  HomeViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

extension HomeView {
    class HomeViewModel: ObservableObject {
        let prospectsViews = [
            ProspectType(type: .everyone, icone: "person.3"),
            ProspectType(type: .contacteds, icone: "checkmark.circle"),
            ProspectType(type: .uncontacted, icone: "questionmark.diamond")
        ]
    }
}
