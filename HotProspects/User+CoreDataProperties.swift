//
//  User+CoreDataProperties.swift
//  HotProspects
//
//  Created by Isaque da Silva on 11/10/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var prospect: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedEmailAddress: String {
        emailAddress ?? "Unknown Email Address"
    }
    
    public var prospectList: [Prospect] {
        let list = prospect as? Set<Prospect> ?? []
        return list.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for prospect
extension User {

    @objc(addProspectObject:)
    @NSManaged public func addToProspect(_ value: Prospect)

    @objc(removeProspectObject:)
    @NSManaged public func removeFromProspect(_ value: Prospect)

    @objc(addProspect:)
    @NSManaged public func addToProspect(_ values: NSSet)

    @objc(removeProspect:)
    @NSManaged public func removeFromProspect(_ values: NSSet)

}

extension User : Identifiable {

}
