//
//  Icons.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import Foundation
import SwiftUI

enum Icons: String {
    case personCropCircle = "person.crop.circle.badge.checkmark"
    case bellFill = "bell.fill"
    case qrCode = "qrcode.viewfinder"
    case line3Horizontal = "line.3.horizontal.decrease.circle"
    case personCrop = "person.crop.square.fill"
    
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
