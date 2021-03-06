//
//  NotebookTableViewController.swift
//  UsingICloudNote
//
//  Created by Lin Wei on 8/10/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit

//Mark: step 5

import CoreData


class NotebookTableViewController: UITableViewController {
    
    var moc:NSManagedObjectContext!
    var notebookArray = [Notebook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
//Mark: step 6
        self.navigationItem.title = "Waiting for icloud..."
        self.navigationItem.rightBarButtonItem?.enabled = false
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Mark: step 7 conditional error handling
        if let context = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            moc = context
        }
        
        //Mark: step 8 add obsever
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "persistentStoreDidChange", name: NSPersistentStoreCoordinatorStoresDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "persistentStoreWillChange:", name: NSPersistentStoreCoordinatorStoresWillChangeNotification, object: moc.persistentStoreCoordinator)
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedIcloudChanges:", name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: moc.persistentStoreCoordinator)
        
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
       
        //Mark: step 9 remove obsever
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSPersistentStoreCoordinatorStoresDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSPersistentStoreCoordinatorStoresWillChangeNotification, object: moc.persistentStoreCoordinator)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: moc.persistentStoreCoordinator)

        
        
    }
    
    
    func persistentStoreDidChange()  {
        //re enable UI and fetch Data
        self.navigationItem.title = "iCloud Loaded"
        self.navigationItem.rightBarButtonItem?.enabled = true
     
        //loadData ()
    }
    func persistentStoreWillChange(notification: NSNotification) {
        
        //loading
        self.navigationItem.title = "iCloud is loading"
        //disable Button
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        moc.performBlock { () -> Void in
            
            if self.moc.hasChanges {
                
                //error handling
                do {
                    try self.moc.save()
                } catch let error as NSError {
                    print("save error \(error)")
                }
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
