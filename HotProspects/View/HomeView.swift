//
//  HomeView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        TabView {
            ProspectsView(filterTypeView: .everyone)
                .tabItem {
                    Label(FilterTypesViews.everyone.rawValue, image: "person.3")
                }
                .tag(FilterTypesViews.everyone)
            
            ProspectsView(filterTypeView: .contacteds)
                .tabItem {
                    Label(FilterTypesViews.contacteds.rawValue, image: "checkmark.circle")
                }
                .tag(FilterTypesViews.contacteds)
            
            ProspectsView(filterTypeView: .uncontacted)
                .tabItem {
                    Label(FilterTypesViews.uncontacted.rawValue, image: "questionmark.diamond")
                }
                .tag(FilterTypesViews.uncontacted)
            
            ProfileView()
                .tabItem {
                    Label(FilterTypesViews.profile.rawValue, image: "person.crop.square")
                }
                .tag(FilterTypesViews.profile)
        }
        .environmentObject(viewModel)
    }
}
