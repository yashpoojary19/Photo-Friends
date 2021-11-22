//
//  Friend+CoreDataProperties.swift
//  ExampleCoreData
//
//  Created by Yash Poojary on 22/11/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var photoid: UUID?
    @NSManaged public var name: String?
    @NSManaged public var details: String?
    
    public var wrappedPhotoId: UUID {
        photoid ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Name unkown"
    }
    
    public var wrappedDetails: String {
        details ?? "Details Unkown"
    }

}

extension Friend : Identifiable {

}
