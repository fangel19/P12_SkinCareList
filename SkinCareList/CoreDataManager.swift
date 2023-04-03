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
    
    func addProduct(product: CodeResult) {
        let entity = Products(context: managedObjectContext)
        entity.brand = product.product.brands
        entity.image = product.product.imageFrontURL
//        entity.date = Date
        entity.type = product.product.productNameFr
        entity.code = product.code
        
        checkThatItAlreadyExists(oneProduct: product.code)
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func checkThatItAlreadyExists(oneProduct: String) -> Bool {
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "code LIKE %@", oneProduct)
        let products = try? managedObjectContext.fetch(request)
        if products!.isEmpty { return false }
        return true
        
    }
}
