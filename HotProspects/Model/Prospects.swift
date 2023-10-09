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
    var isContacted: Bool = false
    
    init(id: UUID = UUID(), name: String, emailAddress: String, isContacted: Bool = false) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
