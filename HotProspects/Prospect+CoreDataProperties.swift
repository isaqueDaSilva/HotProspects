//
//  Prospect+CoreDataProperties.swift
//  HotProspects
//
//  Created by Isaque da Silva on 11/10/23.
//
//

import Foundation
import CoreData


extension Prospect {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prospect> {
        return NSFetchRequest<Prospect>(entityName: "Prospect")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var isContacted: Bool
    @NSManaged public var user: User?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedEmailAddress: String {
        emailAddress ?? "Unknown Email Address"
    }
}

extension Prospect : Identifiable {

}
