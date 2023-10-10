//
//  ProspectManager.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

actor ProspectManager {
    static let shared = ProspectManager()
    var prospects = [Prospects]()
    
    func addNewProspect(name: String, emailAddress: String, isContacted: Bool) {
        let prospect = Prospects(name: name, emailAddress: emailAddress, isContacted: isContacted)
        self.prospects.append(prospect)
    }
}
