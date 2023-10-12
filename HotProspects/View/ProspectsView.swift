//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Isaque da Silva on 07/10/23.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var viewModel: ProspectsController
    let filter: FilterTypesViews
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.wrappedName)
                            .font(.headline)
                            .foregroundColor(prospect.isContacted ? .green : .red)
                        Text(prospect.wrappedEmailAddress)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        Button {
                            viewModel.toggleIsContacted(prospect)
                        } label : {
                            Label(
                                prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted",
                                systemImage: prospect.isContacted ? "person.crop.circle.badge.xmark" : "person.crop.circle.fill.badge.checkmark"
                            )
                        }
                        .tint(prospect.isContacted ? .red : .green)
                        
                        if prospect.isContacted == false {
                            Button {
                                viewModel.addNotifications(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(filter.rawValue)
            .onAppear(perform: viewModel.getUser)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button(action: {
                            viewModel.isShowingScannerValid()
                        }, label: {
                            Label("Scan a QR Code", systemImage: "qrcode.viewfinder")
                        })
                        
                        Menu {
                            Picker("Filter", selection: $viewModel.sortedBy) {
                                ForEach(SortedBy.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
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
}
