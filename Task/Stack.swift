//
//  Stack.swift
//  Task
//
//  Created by Jeff Norton on 7/7/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class Stack {
    
    static let sharedStack = Stack()
    
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() -> NSManagedObjectContext {
        let bundle = NSBundle.mainBundle()
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle])
            else { fatalError("model not found") }
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
                                                                   URL: storeURL(), options: options)
        let context = NSManagedObjectContext(
            concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
    
    static func storeURL () -> NSURL? {
        let documentsDirectory: NSURL? = try? NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
        
        return documentsDirectory?.URLByAppendingPathComponent("db.sqlite")
    }
    
}