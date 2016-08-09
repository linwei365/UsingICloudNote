//
//  CoreDataHelper.swift
//  UsingICloudNote
//
//  Created by Lin Wei on 8/8/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit

//Mark: step 1
import CoreData

class CoreDataHelper: NSObject {
    
   //Mark: step 2 create a class function to insert a new Ojbect
    
    class func insertManagedObject(className:NSString, managedObjectContext:NSManagedObjectContext) -> AnyObject {
       
        let manageOjbect = NSEntityDescription.insertNewObjectForEntityForName(className as String, inManagedObjectContext:managedObjectContext) as NSManagedObject
        
        return manageOjbect
    }
    
    //Mark: step 3 create a class function to fetch results
    class func fetchEnitities(className:NSString,managedObjectContext:NSManagedObjectContext, predicate:NSPredicate?) -> NSArray {
        
        let fetchRequest = NSFetchRequest()
        let entityDescrtiption = NSEntityDescription.entityForName(className as String, inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entityDescrtiption
        
        //default is nil set to return as false
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        fetchRequest.returnsObjectsAsFaults = false
        
        //excute a fetch stored in array
        let items = try! managedObjectContext.executeFetchRequest(fetchRequest)
        
        //returning the fetched results of array
        return items
    }
    //Mark: step 4 jump to UsingICloudNote.xcdatamodeld add new entity

}
