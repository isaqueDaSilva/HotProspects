//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import SwiftUI

struct ProspectsView: View {
    @StateObject var viewModel: ProspectViewModel
    let filter: FilterTypesViews
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filterProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(filter.rawValue)
        }
    }
    
    init(filter: FilterTypesViews) {
        self.filter = filter
        _viewModel = StateObject(wrappedValue: ProspectViewModel(filterType: filter))
    }
}
