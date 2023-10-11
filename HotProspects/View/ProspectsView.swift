//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    @StateObject var viewModel: ProspectViewModel
    let filter: FilterTypesViews
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filterProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.wrappedName)
                            .font(.headline)
                        Text(prospect.wrappedEmailAddress)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        Button {
                            viewModel.toggleIsContacted(prospect)
                        } label: {
                            Label(
                                prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted",
                                systemImage: prospect.isContacted ? "person.crop.circle.badge.xmark" : "person.crop.circle.fill.badge.checkmark"
                            )
                        }
                        .tint(prospect.isContacted ? .red : .green)
                    }
                }
            }
            .navigationTitle(filter.rawValue)
            .toolbar {
                Button(action: {
                    viewModel.isScannerViewOn = true
                }, label: {
                    Label("Scan a QR Code", systemImage: "qrcode.viewfinder")
                })
            }
            .sheet(isPresented: $viewModel.isScannerViewOn, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: viewModel.handleScan)
            })
        }
    }
    
    init(filter: FilterTypesViews) {
        self.filter = filter
        _viewModel = StateObject(wrappedValue: ProspectViewModel(filterType: filter))
    }
}
