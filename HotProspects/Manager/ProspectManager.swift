//
//  ProspectManager.swift
//  HotProspects
//
//  Created by Isaque da Silva on 10/10/23.
//

import CoreData
import Foundation

actor ProspectManager {
    static let shared = ProspectManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var prospectList = [Prospect]()
    
    private func save() {
        do {
            try context.save()
            fetchProspectList()
        } catch let error {
            print("Falied to loading Prospect List. Error: \(error)")
        }
    }
    
    func fetchProspectList() {
        let request = NSFetchRequest<Prospect>(entityName: "Prospect")
        
        do {
            prospectList = try context.fetch(request)
        } catch let error {
            print("Falied to loading Prospect List. Error: \(error)")
        }
    }
    
    func addNewProspect(name: String, emailAddress: String) {
        let newProspect = Prospect(context: context)
        newProspect.id = UUID()
        newProspect.name = name
        newProspect.emailAddress = emailAddress
        newProspect.isContacted = false
        prospectList.append(newProspect)
        save()
    }
    
    func toggleIsContactedStatus(_ prospect: Prospect) {
        prospect.isContacted.toggle()
        save()
    }
    
    private init() {
        self.container = NSPersistentContainer(name: "Prospect")
        self.context = container.viewContext
        
        self.container.loadPersistentStores { (success, error) in
            if (error != nil) {
                print("Falied to loading Prospect List.")
            }
        }
        self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
