//
//  ProfileView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Insert your Name...", text: $viewModel.name)
                        .textContentType(.name)
                    TextField("Insert your email address...", text: $viewModel.emailAddress)
                        .textContentType(.emailAddress)
                }
                
                HStack {
                    Spacer()
                    Image(uiImage: viewModel.qrcodeGenerator())
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
            }
            .navigationTitle("Profile")
        }
    }
}
