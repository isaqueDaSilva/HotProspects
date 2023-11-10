//
//  ProfileView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProspectsController
    var body: some View {
        NavigationView {
            switch viewModel.profileViewState {
            case .createProfile:
                CreateProfile()
            case .loading:
                ProgressView()
            case .profileCreated:
                Profile()
            }
        }
        .environmentObject(viewModel)
    }
}

