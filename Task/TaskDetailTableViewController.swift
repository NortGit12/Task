//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    // MARK: - Stored Properties
    
    var task: Task?
    var dueDateValue: NSDate?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDateDatePicker: UIDatePicker!
    
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 
        
        dueDateTextField.inputView = dueDateDatePicker
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let task = task {
            updateWith(task)
        }
    }
    
    func updateWith(task: Task) {
        
        taskNameTextField.text = task.name
        priorityTextField.text = task.priority
        dueDateTextField.text = task.dueDate?.stringValue()
        notesTextView.text = task.notes
        
    }

    // MARK: - Table view data source

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }

    
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
    
    // MARK: - Action(s)
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        
        self.dueDateValue = sender.date
        
        let dateString = self.dueDateValue?.stringValue()
        
        dueDateTextField.text = dateString
        
    }
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        guard let priority = priorityTextField.text else {
            print("No value in priorityTextField")
            return
        }
        
        guard let name = taskNameTextField.text
//            , priority = priorityTextField.text
            , notes = notesTextView.text
            where name.characters.count > 0
        else { return }
        
        if let task = task {
            
            // Update existing Task
            TaskController.sharedController.updateTask(task, name: name, priority: priority, notes: notes, dueDate: dueDateValue, isComplete: false)
            
        } else {
            
            // Save a new Task
            TaskController.sharedController.addTask(name, priority: priority, notes: notes, dueDate: dueDateValue)
            
        }
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    
    @IBAction func userTappedView(sender: AnyObject) {
        
        dismissKeyboard()
        
        taskNameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
//        dueDateTextField.text = dueDateValue?.stringValue()
        
    }
    
    
    
    // MARK: - Methods
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}