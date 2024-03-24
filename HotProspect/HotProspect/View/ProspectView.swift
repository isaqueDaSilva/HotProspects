//
//  ProspectView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 22/03/24.
//

import SwiftUI

struct ProspectView: View {
    let prospectType: ProspectTagView
    var body: some View {
        NavigationStack {
            VStack {
                // Check if has some prospect save
                
                // otherwise return ContentUnavailableView
                ContentUnavailableView(
                    prospectType.contentUnavaiableTitle,
                    systemImage: prospectType.contentUnavaiableIcon,
                    description: prospectType.contentUnavaibleDescription
                )
            }
            .navigationTitle(prospectType.rawValue)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button(action: {
                           
                        }, label: {
                            Label("Scan a QR Code", systemImage: Icons.qrCode.rawValue)
                        })
                        
                        Menu {
                            
                        } label: {
                            Image(systemName: Icons.line3Horizontal.rawValue)
                        }
                    }
                }
            }
        }
    }
}

// MARK: Prospect View Populated

extension ProspectView {
    @ViewBuilder
    func ProspectViewPopilated() -> some View {
        List(0..<10) { integer in
            VStack(alignment: .leading) {
                Text("Name \(integer + 1)")
                    .bold()
                    .lineLimit(1)
                Text("email \(integer + 1)")
                    .foregroundStyle(.secondary)
            }
            .swipeActions {
                Button {
                    // Do something
                } label: {
                    Label("Contacted me", systemImage: Icons.personCropCircle.rawValue)
                }
                .tint(.green)
                
                Button {
                    // Do something...
                } label: {
                    Label("Notify me", systemImage: Icons.bellFill.rawValue)
                }
                .tint(.orange)
            }
        }
    }
}

#Preview {
    ProspectView(prospectType: .uncontacteds)
}
