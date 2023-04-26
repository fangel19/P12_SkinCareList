//
//  TestCoreDataStack.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import Foundation
import CoreData
@testable import SkinCareList

class TestCoreDataStack: CoreDataStack {
    static let modelName = "SkinCaleList"
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    var testContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: TestCoreDataStack.modelName, managedObjectModel: TestCoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var testContainer: NSPersistentContainer {
        return TestCoreDataStack().testContainer
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    override func saveContext() {
        do {
            try mainContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}


