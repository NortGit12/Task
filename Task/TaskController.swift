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
    
    // MARK: - Initializer(s)
    
    
    
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
        
        
        
    }
    
}