//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    // MARK: - Stored Properties
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedController.incompleteTasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("taskListTableViewCell", forIndexPath: indexPath) as? ButtonTableViewCell
        
        print("Complete tasks: \(TaskController.sharedController.completedTasks)")
        print("Incomplete tasks: \(TaskController.sharedController.incompleteTasks)")

        let task = TaskController.sharedController.incompleteTasks[indexPath.row]
        
        cell?.primaryLabel.text = task.name
        
        cell?.delegate = self
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - ButtonTableViewCellDelegate
    
    func buttonCellButtonTapped(cell: ButtonTableViewCell) {
        
        // Capture the Task
        guard let cellIndexPath = tableView.indexPathForCell(cell) else { return }
        
        let task = TaskController.sharedController.incompleteTasks[cellIndexPath.row]
        
        print("Task = \(task.name)")
        
        // Toggle isCompleted (which also saves the modified Task
        TaskController.sharedController.toggleIsCompleted(task)
        
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()

    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let task = TaskController.sharedController.tasks[indexPath.row]
            
            print("Num tasks (before delete) = \(TaskController.sharedController.tasks.count)")
            
            TaskController.sharedController.removeTask(task)
            
            print("Num tasks (after delete) = \(TaskController.sharedController.tasks.count)")
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
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
                    
                    // Am I done packing?
                    taskDetailTableViewController.task = task
                }
            }
        }
    }
    

}
