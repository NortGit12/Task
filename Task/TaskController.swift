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
    
    var tasks: [Task] {
        let request = NSFetchRequest(entityName: "Task")
        
        let tasks = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request)) as? [Task]
        
        return tasks ?? []

    }
    
    var completedTasks: [Task] {
        
        return tasks.filter({ task -> Bool in
            task.isComplete == true
        })
        
    }
    
    var incompleteTasks: [Task] {
        
        return tasks.filter({ task -> Bool in
            task.isComplete == false
        })
        
    }
    
    var mockTasks: [Task] {
        
        guard let putGarbageOutTask = Task(name: "Put Out Garbage", notes: "Empty all garbages and take the main garbage can out to the curb", dueDate: NSDate()),
            let doHomeworkTask = Task(name: "Do Homework", notes: "Finish today's project and watch videos for tomorrow", dueDate: NSDate()),
            let mowLawnTask = Task(name: "Mow the Lawn", notes: "Get it done"),
            let moveFurnitureTask = Task(name: "Move Furniture Back", notes: "Move all of the furniture back in and put it where it goes") else { return [] }
        
        moveFurnitureTask.isComplete = true
        
        return [putGarbageOutTask, doHomeworkTask, mowLawnTask, moveFurnitureTask]
    }
    
    // MARK: - Initializer(s)
    
    // MARK: - Method(s)
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        
        _ = Task(name: name, notes: notes, dueDate: due)
        
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?, isComplete: Bool) {
        
        if name.characters.count > 0 {
            
            task.name = name
            task.notes = notes
            task.dueDate = due
            task.isComplete = isComplete
            
            saveToPersistentStore()
        }
    }
    
    func removeTask(task: Task) {
        
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            try moc.save()
        } catch {
            print("Yuckiness happened while trying to save the Managed Object Context :(")
        }
        
    }
    
    func fetchTasks() -> [Task] {
        
        return self.mockTasks
        
    }
    
}