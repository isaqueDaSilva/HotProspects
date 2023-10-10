//
//  ProspectType.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

struct ProspectType: Identifiable {
    let id = UUID()
    let type: FilterTypesViews
    let icone: String
}
