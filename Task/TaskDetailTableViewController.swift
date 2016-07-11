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
//    var dueDateAtMidnightValue: NSDate = NSDate()
    var dueDate: NSDate = NSDate()
    var dueDateString: String = ""
    let priorityTextDefault = "2 - Medium"
    
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
        
        if let task = self.task {
            updateWith(task)
        }
    }
    
    func updateWith(task: Task) {
        
        if let task = self.task {
            
            self.dueDate = task.dueDate
            
            // Populate the views with the existing task's data
            taskNameTextField.text = task.name
            priorityTextField.text = task.priority
            dueDateTextField.text = task.dueDate.stringValue()
            dueDateDatePicker.setDate(task.dueDate, animated: true)
            notesTextView.text = task.notes
            
        } else {
            
            self.dueDate = NSDate()
            
            // Populate the views with some defaults
            priorityTextField.text = priorityTextDefault
            dueDateTextField.text = dueDate.stringValue()
            
        }
        
    }
    
    // MARK: - Action(s)
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        
        self.dueDate = sender.date
        
        dueDateTextField.text = self.dueDate.stringValue()
        
    }
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        guard let name = taskNameTextField.text
            , priority = priorityTextField.text
            , notes = notesTextView.text
            where name.characters.count > 0
        else { return }
        
        if let task = task {
            
            // Update existing Task
            TaskController.sharedController.updateTask(task, name: name, priority: priority, dueDate: self.dueDate, isComplete: false, notes: notes)
            
        } else {
            
            // Save a new Task
            TaskController.sharedController.addTask(name, priority: priority, dueDate: self.dueDate, notes: notes)
            
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
//        dueDateTextField.text = dueDateValue.stringValue()
        
    }
    
    
    
    // MARK: - Methods
    
//    func calcuateMidnightOfDate(date: NSDate) -> NSDate {
//        
//        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//        
//        let newDate = cal.dateBySettingHour(23, minute: 59, second: 59, ofDate: date, options: NSCalendarOptions())!
//        
//        let midnightOnDate = NSDate(timeIntervalSinceReferenceDate: newDate.timeIntervalSince1970)
//        
//        return midnightOnDate
//    }
    
    
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