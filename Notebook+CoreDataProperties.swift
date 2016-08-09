//
//  Notebook+CoreDataProperties.swift
//  UsingICloudNote
//
//  Created by Lin Wei on 8/9/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Notebook {

    @NSManaged var title: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var note: NSSet?

}
