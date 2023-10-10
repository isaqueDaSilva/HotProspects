//
//  ProfileViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

extension ProfileView {
    class ProfileViewModel: ObservableObject {
        @Published var name = ""
        @Published var emailAddress = ""
        @Published var isContacted = false
    }
}
