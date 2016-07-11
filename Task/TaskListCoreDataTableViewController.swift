//
//  TaskListCoreDataTableViewController.swift
//  Task
//
//  Created by Jeff Norton on 7/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskListCoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {
    
    // MARK: - Stored Properties
    
    var fetchedResultsController: NSFetchedResultsController!
    
    // MARK: - General

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFetchedResultsController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard let sectionCount = fetchedResultsController.sections?.count else { return 0 }
        
        return sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let currentSectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        
        return currentSectionInfo.numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskListTableViewCell", forIndexPath: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        

        configureCell(cell, indexPath: indexPath)
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let sections = fetchedResultsController.sections else { return nil }
            
        let sectionInfo = sections[section]
        
        guard let sectionInfoNameAsInt = Int(sectionInfo.name) else { return nil }
        
        switch sectionInfoNameAsInt {
        case 0: return "Incomplete"
        case 1: return "Completed"
        default: return "Unknown"
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
         
            guard let task = fetchedResultsController.objectAtIndexPath(indexPath) as? Task else { return }
            
            TaskController.sharedController.removeTask(task)
        }
    }
    

    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move: break
        case .Update: break
        }
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Update:
            configureCell(self.tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - ButtonTableViewCellDelegate
    
    func buttonCellButtonTapped(cell: ButtonTableViewCell) {
        
        guard let indexPath = tableView.indexPathForCell(cell), task = fetchedResultsController.objectAtIndexPath(indexPath) as? Task else { return }
        
        TaskController.sharedController.toggleIsCompleted(task)
        
        cell.updateWith(task)
        
    }
    
    
    
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
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    
                    let task = fetchedResultsController.objectAtIndexPath(indexPath) as? Task
                    
                    // Did I finish packing?
                    taskDetailTableViewController.task = task
                    
                }
            }
        }
    }
    

}
