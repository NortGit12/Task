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

    var tasks: [Task] = []
    
//    var tasks: [Task] {
//        return tasksWithPredicate(nil)
//    }
    
//    var completedTasks: [Task] {
//        let predicate = NSPredicate(format: "isComplete == TRUE")
//        return tasksWithPredicate(predicate)
//    }
    
//    var incompleteTasks: [Task] {
//        let predicate = NSPredicate(format: "isComplete == FALSE")
//        return tasksWithPredicate(predicate)
//    }
    
//    var mockTasks: [Task] {
//        
//        guard let putGarbageOutTask = Task(name: "Put Out Garbage", notes: "Empty all garbages and take the main garbage can out to the curb", dueDate: NSDate()),
//            let doHomeworkTask = Task(name: "Do Homework", notes: "Finish today's project and watch videos for tomorrow", dueDate: NSDate()),
//            let mowLawnTask = Task(name: "Mow the Lawn", notes: "Get it done"),
//            let moveFurnitureTask = Task(name: "Move Furniture Back", notes: "Move all of the furniture back in and put it where it goes") else { return [] }
//        
//        moveFurnitureTask.isComplete = true
//        
//        return [putGarbageOutTask, doHomeworkTask, mowLawnTask, moveFurnitureTask]
//    }
    
    // MARK: - Initializer(s)
    
    init() {
    
        let request = NSFetchRequest(entityName: "Task")
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "dueDate", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "priority", cacheName: nil)
        
//        do {
//            return try moc.executeFetchRequest(request) as! [Task]
//        } catch {
//            return []
//        }
        
    }
    
    // MARK: - Method(s) (CRUD)
    
    func addTask(name: String, priority: String, notes: String?, dueDate: NSDate?) {
        
        _ = Task(name: name, priority: priority, notes: notes, dueDate: dueDate)
        
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, priority: String, notes: String?, dueDate: NSDate?, isComplete: Bool) {
        
        if name.characters.count > 0 {
            
            task.name = name
            task.priority = priority
            task.notes = notes
            task.dueDate = dueDate
            task.isComplete = isComplete
            
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
    
    func tasksWithPredicate(predicate: NSPredicate?) -> [Task] {
        
        let request = NSFetchRequest(entityName: "Task")
        request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "dueDate", ascending: true)]
        
        do {
            return try moc.executeFetchRequest(request) as! [Task]
        } catch {
            return []
        }
    }
    
}