//
//  ProfileViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import UIKit

extension ProfileView {
    class ProfileViewModel: ObservableObject {
        @Published var name = ""
        @Published var emailAddress = ""
        @Published var isContacted = false
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        func qrcodeGenerator() -> UIImage {
            let string = "\(name)\n\(emailAddress)"
            filter.message = Data(string.utf8)
            
            if let outputImage = filter.outputImage {
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
            
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
    }
}
