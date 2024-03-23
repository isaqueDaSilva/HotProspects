//
//  ProspectTagView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import Foundation
import SwiftUI

enum ProspectTagView: String, Identifiable, CaseIterable {
    case everyone = "Everyone"
    case contacteds = "Contacteds"
    case uncontacteds = "Uncontacteds"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .everyone: "person.3.fill"
        case .contacteds: "checkmark.circle.fill"
        case .uncontacteds: "questionmark.diamond.fill"
        }
    }
    
    var contentUnavaiableTitle: String {
        switch self {
        case .everyone: "No Prospect added."
        case .contacteds: "No Prospect contacted."
        case .uncontacteds: "No prospect uncontacted."
        }
    }
    
    var contentUnavaiableIcon: String {
        switch self {
        case .everyone: "person.2.slash"
        case .contacteds: "questionmark.circle.fill"
        case .uncontacteds: "questionmark.diamond.fill"
        }
    }
    
    var contentUnavaibleDescription: Text? {
        switch self {
        case .everyone:
            Text("Click on the \(Icons.qrCode.systemImage) on Tool Bar and add a new Prospect for your list.")
        case .contacteds:
            Text("Swipe some Prospect that you was contacted and click on \(Icons.personCropCircle.systemImage) Button for mark them as contacted.")
        case .uncontacteds: nil
        }
    }
}
