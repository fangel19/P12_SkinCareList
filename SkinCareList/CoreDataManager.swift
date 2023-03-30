//
//  CoreDataManager.swift
//  SkinCareList
//
//  Created by angelique fourny on 30/03/2023.
//
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    
    let managedObjectContext: NSManagedObjectContext
    
    //MARK: - Initialization
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataStack.sharedInstance.viewContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func addProduct(product: Product) {
        let entity = Products(context: managedObjectContext)
        entity.name = product.brands //FIXME: changer le nom de name
        entity.image = product.imageFrontURL
        
        //TODO: terminer la correspondance avec le model
        CoreDataStack.sharedInstance.saveContext()
    }
}
