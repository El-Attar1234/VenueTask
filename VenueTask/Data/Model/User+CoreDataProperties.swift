//
//  User+CoreDataProperties.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var age: String?
    @NSManaged public var password: String?

}

extension User: Identifiable {

}
