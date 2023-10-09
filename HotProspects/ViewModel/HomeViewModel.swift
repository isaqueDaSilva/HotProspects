//
//  HomeViewModel.swift
//  HotProspects
//
//  Created by Isaque da Silva on 09/10/23.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var prospects = [Prospects]()
}
