//
//  CoreDataStack.swift
//  SkinCareList
//
//  Created by angelique fourny on 30/03/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Properties
    
    let persistentContainerName = "SkinCareList"
    
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    // MARK: - Private
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: {storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        })
        return container
    }()
    
    func saveContext() {
        
        do {
            try viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
