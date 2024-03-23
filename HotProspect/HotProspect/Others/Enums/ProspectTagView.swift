//
//  TagView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import Foundation

enum TagView: String, Identifiable {
    case everyone = "Everyone"
    case contacteds = "Contacteds"
    case uncontacteds = "Uncontacteds"
    case profile = "Profile"
    
    var id: String { self.rawValue }
    
    var icons: String {
        switch self {
        case .everyone:
            return "person.3.fill"
        case .contacteds:
            return "checkmark.circle.fill"
        case .uncontacteds:
            return "questionmark.diamond.fill"
        case .profile:
            return "person.crop.circle"
        }
    }
}
