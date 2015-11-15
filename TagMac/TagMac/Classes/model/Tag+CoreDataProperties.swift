//
//  Tag+CoreDataProperties.swift
//  TagMac
//
//  Created by kimimaro on 15/11/15.
//  Copyright © 2015年 OneBox Design. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tag {

    @NSManaged var tag_name: String?
    @NSManaged var tag_level: NSNumber?
    @NSManaged var tag_id: String?
    @NSManaged var is_fav: NSNumber?
    @NSManaged var up_tag_id: String?
    @NSManaged var cxt_id: NSManagedObject?

}
