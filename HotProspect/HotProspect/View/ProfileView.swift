//
//  ProfileView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
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
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(value: "abc") {
                        LabeledContent("Contacted with me:", value: "5")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
