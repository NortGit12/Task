//
//  Task.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {

    convenience init?(name: String, priority: String? = nil, dueDate: NSDate, isComplete: Bool = false, notes: String? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context) else { return nil }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        
        if let priority = priority {
            self.priority = priority
        }
        
        self.dueDate = dueDate
        self.isComplete = isComplete
        self.notes = notes
        
    }

}
