//
//  ProspectManager.swift
//  HotProspects
//
//  Created by Isaque da Silva on 10/10/23.
//

import CoreData
import Foundation

actor ProspectManager {
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var user = [User]()
    
    private func save() {
        do {
            try context.save()
            fetchUser()
        } catch let error {
            print("Falied to loading Prospect List. Error: \(error)")
        }
    }
    
    func fetchUser() {
        let request = NSFetchRequest<User>(entityName: "User")
        do {
            user = try context.fetch(request)
        } catch let error {
            print("Falied to loading Prospect List. Error: \(error)")
        }
    }
    
    func createNewProfile(name: String, emailAddress: String) {
        let newProfile = User(context: context)
        newProfile.id = UUID()
        newProfile.name = name
        newProfile.emailAddress = emailAddress
        save()
    }
    
    func addNewProspect(name: String, emailAddress: String) {
        let newProspect = Prospect(context: context)
        newProspect.id = UUID()
        newProspect.name = name
        newProspect.emailAddress = emailAddress
        newProspect.isContacted = false
        newProspect.user = User(context: context)
        
        guard let userIndex = user.first else { return }
        newProspect.user?.id = userIndex.id
        newProspect.user?.name = userIndex.name
        newProspect.user?.emailAddress = userIndex.emailAddress
        userIndex.prospect?.adding(newProspect)
        save()
    }
    
    func toggleIsContactedStatus(_ prospect: Prospect) {
        prospect.isContacted.toggle()
        save()
    }
    
    func deleteUser() {
        guard let user = user.first else { return }
        context.delete(user)
        save()
    }
    
    init() {
        self.container = NSPersistentContainer(name: "UserModel")
        self.context = container.viewContext
        
        self.container.loadPersistentStores { (success, error) in
            if (error != nil) {
                print("Falied to loading Prospect List.")
            }
        }
        self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
