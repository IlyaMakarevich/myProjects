//
//  Photo+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by MacBook Pro  on 01.01.2020.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var author: String?
    @NSManaged public var mediaURL: String?
    @NSManaged public var tags: String?

}
