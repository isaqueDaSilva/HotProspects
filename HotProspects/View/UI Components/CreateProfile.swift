//
//  CreateProfile.swift
//  HotProspects
//
//  Created by Isaque da Silva on 12/10/23.
//

import SwiftUI

struct CreateProfile: View {
    @EnvironmentObject var viewModel: ProspectsController
    var body: some View {
        Form {
            Section {
                TextField("Insert your Name...", text: $viewModel.name)
                    .textContentType(.name)
                TextField("Insert your email address...", text: $viewModel.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button {
                        viewModel.profileViewState = .loading
                        viewModel.createNewProfile()
                    } label: {
                        Text("Create New Profile")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
        }
        .navigationTitle("Create Profile")
    }
}
