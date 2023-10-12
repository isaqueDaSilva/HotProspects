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
            .onAppear(perform: viewModel.getPeoples)
            .toolbar {
                Button(action: {
                    viewModel.isShowingScannerValid()
                }, label: {
                    Label("Scan a QR Code", systemImage: "qrcode.viewfinder")
                })
            }
            .sheet(isPresented: $viewModel.isScannerViewOn, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: viewModel.handleScan)
            })
            .alert("Create an Account", isPresented: $viewModel.showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text("Before proceeding, create an account so that the App works correctly.")
            }

        }
    }
    
    init(filter: FilterTypesViews) {
        self.filter = filter
        _viewModel = StateObject(wrappedValue: ProspectViewModel(filterType: filter))
    }
}
