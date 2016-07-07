//
//  TaskController.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class TaskController {
    
    // MARK: - Stored Properties
    
    static let sharedController = TaskController()
    
    var tasks: [Task] = []
    
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
        
        let putGarbageOutTask = Task(name: "Put Out Garbage", notes: "Empty all garbages and take the main garbage can out to the curb", dueDate: NSDate())
        let doHomeworkTask = Task(name: "Do Homework", notes: "Finish today's project and watch videos for tomorrow", dueDate: NSDate())
        let mowLawnTask = Task(name: "Mow the Lawn", notes: "Get it done")
        let moveFurnitureTask = Task(name: "Move Furniture Back", notes: "Move all of the furniture back in and put it where it goes")
        
        moveFurnitureTask.isComplete = true
        
        return [putGarbageOutTask, doHomeworkTask, mowLawnTask, moveFurnitureTask]
        
    }
    
    // MARK: - Initializer(s)
    
    init() {
        
        self.tasks = fetchTasks()
        
    }
    
    // MARK: - Method(s)
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        
        
        
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?, isComplete: Bool) {
        
        
        
        saveToPersistentStore()
    }
    
    func removeTask(task: Task) {
        
        
        
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        
        
        
    }
    
    func fetchTasks() -> [Task] {
        
        return self.mockTasks
        
    }
    
}