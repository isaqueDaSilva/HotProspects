//
//  HomeView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ProspectsView()
                .tabItem {
                    Label(FilterTypesViews.everyone.rawValue, image: "person.3")
                }
                .tag(FilterTypesViews.everyone)
            
            ProspectsView()
                .tabItem {
                    Label(FilterTypesViews.contacteds.rawValue, image: "checkmark.circle")
                }
                .tag(FilterTypesViews.contacteds)
            
            ProspectsView()
            
            ProfileView()
        }
    }
}
