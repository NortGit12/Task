//
//  TaskController.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // MARK: - Stored Properties
    
    static let sharedController = TaskController()
    
    let moc = Stack.sharedStack.managedObjectContext
    
    let fetchedResultsController: NSFetchedResultsController
    
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    // MARK: - Initializer(s)
    
    init() {
    
        let request = NSFetchRequest(entityName: "Task")
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "dueDate", ascending: true), NSSortDescriptor(key: "priority", ascending: false), NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error fetching tasks: \(error)")
        }
        
    }
    
    // MARK: - Method(s) (CRUD)
    
    func addTask(name: String, priority: String, dueDate: NSDate, notes: String?) {
        
        _ = Task(name: name, priority: priority, dueDate: dueDate, notes: notes)
        
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, priority: String, dueDate: NSDate, isComplete: Bool, notes: String?) {
        
        if name.characters.count > 0 {
            
            task.name = name
            task.priority = priority
            task.dueDate = dueDate
            task.isComplete = isComplete
            task.notes = notes
            
            saveToPersistentStore()
        }
    }
    
    func removeTask(task: Task) {
        
        moc.deleteObject(task)
        
        saveToPersistentStore()
    }
    
    func toggleIsCompleted(task: Task) {
        
        switch task.isComplete.boolValue {
        case true: task.isComplete = false
        case false: task.isComplete = true
        }
        
        saveToPersistentStore()
    }
    
    // MARK: - Method(s) (Persistence)
    
    func saveToPersistentStore() {
        
        do {
            try moc.save()
        } catch {
            print("Yuckiness happened while trying to save the Managed Object Context :(")
        }
        
    }
    
    // MARK: - Method(s) (Misc)
    
//    func tasksWithPredicate(predicate: NSPredicate?) -> [Task] {
//        
//        let request = NSFetchRequest(entityName: "Task")
//        request.predicate = predicate
//        
//        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "dueDate", ascending: true)]
//        
//        do {
//            return try moc.executeFetchRequest(request) as! [Task]
//        } catch {
//            return []
//        }
//    }
    
}