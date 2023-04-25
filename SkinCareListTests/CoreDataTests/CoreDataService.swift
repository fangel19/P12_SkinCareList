//
//  CoreDataService.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import Foundation
import CoreData
@testable import SkinCareList

class CoreDataService {
    
    private let coreDataStack: TestCoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack as! TestCoreDataStack
        self.managedObjectContext = coreDataStack.viewContext
    }
    
//    func save(product: Products) {
//        coreDataStack.saveContext()
//    }
    
    func addProduct(product: CodeResult) {
        
        guard !checkThatItAlreadyExists(sameProduct: product.code) else {return}
        
        let entity = Products(context: managedObjectContext)
        entity.brand = product.product.brands
        entity.image = product.product.imageFrontURL
        entity.type = product.product.productNameFr
        entity.code = product.code
        
        
        coreDataStack.saveContext()
    }
    
    func checkThatItAlreadyExists(sameProduct: String) -> Bool {
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "code LIKE %@", sameProduct)
        let products = try? managedObjectContext.fetch(request)
        if products!.isEmpty { return false }
        return true
        
    }
    
    func deleteProduct(with code: String) {
        
        let fetchRequest = Products.fetchRequest()
        // Add a predicate to filter the results according to your needs
        fetchRequest.predicate = NSPredicate(format: "code == %@", code)
        
        do {
            // Step 2: Retrieve the object
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            
            // Check if an object has been found
            if let objectDelete = fetchedObjects.first {
                
                // Step 3: Update the object's attributes
                managedObjectContext.delete(objectDelete)
                
                // Step 4: Save changes
                try managedObjectContext.save()
            } else {
                print("Aucun objet trouvé avec la valeur de recherche spécifiée.")
            }
        } catch {
            print("Erreur lors de la récupération de l'objet: \(error)")
        }
    }
    
    
    func updateDate(with searchValue: String, date: String) {
        
        let fetchRequest = Products.fetchRequest()
        // Add a predicate to filter the results according to your needs
        fetchRequest.predicate = NSPredicate(format: "code == %@", searchValue)
        
        do {
            // Step 2: Retrieve the object
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            
            // Check if an object has been found
            if let objectToUpdate = fetchedObjects.first {
                
                // Step 3: Update the object's attributes
                objectToUpdate.date = date
                
                // Step 4: Save changes
                try managedObjectContext.save()
            } else {
                print("Aucun objet trouvé avec la valeur de recherche spécifiée.")
            }
        } catch {
            print("Erreur lors de la récupération de l'objet: \(error)")
        }
    }
}
