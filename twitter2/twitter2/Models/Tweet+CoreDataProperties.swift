//
//  Tweet+CoreDataProperties.swift
//  
//
//  Created by MacBook Pro  on 31.12.2019.
//
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet")
    }

    @NSManaged public var screen_name: String?
    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var created_at: String?
    @NSManaged public var profile_image_url: String?

}
