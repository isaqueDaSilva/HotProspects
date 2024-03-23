//
//  ContentView.swift
//  HotProspect
//
//  Created by Isaque da Silva on 21/03/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ForEach(ProspectTagView.allCases) { prospect in
                ProspectView(prospectType: prospect)
                    .tabItem {
                        Label(prospect.rawValue, systemImage: prospect.icon)
                    }
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: Icons.personCrop.rawValue)
                }
        }
    }
}

#Preview {
    HomeView()
}
