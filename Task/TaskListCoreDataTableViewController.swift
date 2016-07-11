//
//  TaskListCoreDataTableViewController.swift
//  Task
//
//  Created by Jeff Norton on 7/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskListCoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Stored Properties
    
    var fetchedResultsController: NSFetchedResultsController!
    
    // MARK: - General

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeFetchedResultsController()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard let numberOfSections = fetchedResultsController.sections?.count else { return 0 }
        
        return numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchedResultsController.sections else { return 0 }
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskListTableViewCell", forIndexPath: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }

        configureCell(cell, indexPath: indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let sections = fetchedResultsController.sections else { return nil }
        
        let sectionInfo = sections[section]
        
        guard let isCompletedInt = Int(sectionInfo.name) else { return nil }
        
        switch isCompletedInt {
        case 0: return "Incomplete"
        case 1: return "Completed"
        default: return "Incomplete"
        }
        
    }
    

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
    
    
    // MARK: - Misc
    
    func initializeFetchedResultsController() {
        
        fetchedResultsController = TaskController.sharedController.fetchedResultsController
        
        fetchedResultsController.delegate = self
        
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        guard let cell = cell as? ButtonTableViewCell, let task = fetchedResultsController.objectAtIndexPath(indexPath) as? Task else { return }
        
        cell.updateWith(task)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // How am I getting there?
        if segue.identifier == "viewExistingTaskSegue" {
            
            // Where am I going?
            if let taskDetailTableViewController = segue.destinationViewController as? TaskDetailTableViewController {
                
                // What do I need to pack?
                if let index = tableView.indexPathForSelectedRow?.row {
                    
                    let task = TaskController.sharedController.tasks[index]
                    
                    // Did I finish packing?
                    taskDetailTableViewController.task = task
                    
                }
            }
        }
    }
    

}
