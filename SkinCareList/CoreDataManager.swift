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
        entity.brand = product.brands
        entity.image = product.imageFrontURL
//        entity.date = Date
        entity.type = product.productNameFr
        
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func checkThatItAlreadyExists(oneProduct: String) -> Bool {
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "label LIKE %@", oneProduct)
        let products = try? managedObjectContext.fetch(request)
        if products!.isEmpty { return false }
        return true
        
    }
}
