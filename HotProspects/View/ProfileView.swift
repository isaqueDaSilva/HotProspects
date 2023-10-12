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
            if viewModel.userExist {
                List {
                    Section {
                        ForEach(viewModel.user) {
                            Text($0.wrappedName)
                            Text($0.wrappedEmailAddress)
                        }
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Image(uiImage: viewModel.qrcodeGenerator()!)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .contextMenu {
                                    Button{
                                        viewModel.saveQRCode()
                                    } label: {
                                        Label("Save to Photos", systemImage: "square.and.arrow.down")
                                    }
                                }
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
                }
                .navigationTitle("Profile")
                .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.alertMessage)
                }
                .toolbar {
                    Button {
                        viewModel.showingDeleteProfileAlert = true
                    } label: {
                        Label("Delete profile", systemImage: "trash")
                    }

                }
                .alert("Delete Profile", isPresented: $viewModel.showingDeleteProfileAlert) {
                    Button("Delete", role: .destructive) {
                        viewModel.deleteUser()
                    }
                    
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to delete this profile?")
                }
            } else {
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
    }
}

