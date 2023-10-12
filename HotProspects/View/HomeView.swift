//
//  HomeView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ProspectsController()
    var body: some View {
        TabView {
            ForEach(viewModel.prospectsViews) { prospect in
                ProspectsView(filter: prospect.type)
                    .tabItem {
                        VStack {
                            Image(systemName: prospect.icone)
                            Text(prospect.type.rawValue)
                        }
                    }
                    .tag(prospect.type)
            }
            
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.square")
                        Text("Profile")
                    }
                }
                .tag("Profile")
        }
        .environmentObject(viewModel)
    }
}

