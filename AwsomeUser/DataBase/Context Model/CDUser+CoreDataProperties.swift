//
//  CDUser+CoreDataProperties.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var password: Int16
    @NSManaged public var userName: String?
    @NSManaged public var id: UUID?

    func convertToUser() -> User
        {
            return User(fullName: self.fullName!, userName: self.userName!, password: self.password, id: self.id!)
        }
}

extension CDUser : Identifiable {

}
