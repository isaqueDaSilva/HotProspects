//
//  Prospects.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

struct Prospects: Identifiable, Codable {
    var id = UUID()
    let name: String
    let emailAddress: String
    let isContacted: Bool
}
