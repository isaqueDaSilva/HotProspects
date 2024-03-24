//
//  ProfileView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingConfirmationDialog = false
    @State private var showingCreateAccountAlert  = false
    @State private var showingLoginAlert  = false
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // User Logged
                    UserLogged()
                    // Case no user has logged.
                    NoUserLogged()
                }
                
                Section {
                    NavigationLink(value: "abc") {
                        LabeledContent("Contacted with me:", value: "5")
                    }
                }
                
                Section {
                    NavigationLink(value: "abc") {
                        Text("Notifications")
                    }
                } footer: {
                    Text(Texts.notificationFooterTextProfileView.rawValue)
                }
                
                Section {
                    Button("Turn a Host") {
                        
                    }
                } footer: {
                    Text(Texts.turnAHostFooterTextProfileView.rawValue)
                }
                
                Section {
                    Button("Sign Out", role: .destructive) {
                        
                    }
                }
            }
            .navigationTitle("Account")
            .confirmationDialog(
                "Choice an Action",
                isPresented: $showingConfirmationDialog
            ) {
                Button {
                    showingLoginAlert = true
                } label: {
                    Text("Login")
                }
                
                Button {
                    showingCreateAccountAlert = true
                } label: {
                    Text("Create an Account")
                }
            }
            .alert(
                "Login",
                isPresented: $showingLoginAlert
            ) {
                TextField("Email", text: $email)
                TextField("Pasword", text: $password)
                
                Button("Login") {}
                
                Button("Cancel", role: .cancel) {}
            }
        }
        .alert(
            "Create an Account",
            isPresented: $showingCreateAccountAlert
        ) {
            TextField("Email", text: $email)
            TextField("Pasword", text: $password)
            TextField("Confirm Pasword", text: $confirmPassword)
            
            Button("Create") { }
            
            Button("Cancel", role: .cancel) { }
        }
    }
}

// MARK: - No user Logged
extension ProfileView {
    @ViewBuilder
    func NoUserLogged() -> some View {
        Button {
            showingConfirmationDialog = true
        } label: {
            Text("No User Logged.")
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - User Logged

extension ProfileView {
    @ViewBuilder
    func UserLogged() -> some View {
        NavigationLink(value: "abc") {
            LabeledContent {
                Icons.qrCode.systemImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } label: {
                VStack(alignment: .leading) {
                    Text("Name")
                        .bold()
                        .lineLimit(1)
                    Text("email")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
