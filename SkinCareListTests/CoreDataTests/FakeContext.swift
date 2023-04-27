//
//  TestCoreDataStack.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import Foundation
import CoreData
@testable import SkinCareList

class FakeContext: CoreDataStack {
    static let modelName = "SkinCareList"
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    var testContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: FakeContext.modelName, managedObjectModel: FakeContext.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var testContainer: NSPersistentContainer {
        return FakeContext().testContainer
    }
    
    static var testContext: NSManagedObjectContext {
        return testContainer.viewContext
    }
}


