//
//  ProspectViewExtension.swift
//  HotProspects
//
//  Created by Isaque da Silva on 12/10/23.
//

import Foundation

extension ProspectsView {
    var sorted: [Prospect] {
        guard let user = viewModel.user.first else { return [] }
        switch viewModel.sortedBy {
        case .increasing:
            return user.prospectList.sorted { $0.wrappedName < $1.wrappedName }
        case .decreasing:
            return user.prospectList.sorted { $0.wrappedName > $1.wrappedName }
        }
    }
    
    var filterProspects: [Prospect] {
        switch filter {
        case .everyone:
            return sorted
        case .contacteds:
            return sorted.filter { $0.isContacted }
        case .uncontacted:
            return sorted.filter { !$0.isContacted }
        }
    }
}
