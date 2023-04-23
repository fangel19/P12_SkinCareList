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
        fetchRequest.predicate = NSPredicate(format: "code == %@", code)
        
        do {
            // Étape 2: Récupérer l'objet
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            
            // Vérifiez si un objet a été trouvé
            if let objectDelete = fetchedObjects.first {
                
                // Étape 4: Sauvegarder les modifications
                managedObjectContext.delete(objectDelete)
                
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
        // Ajoutez un prédicat pour filtrer les résultats selon vos besoins
        fetchRequest.predicate = NSPredicate(format: "code == %@", searchValue)
        
        do {
            // Étape 2: Récupérer l'objet
            let fetchedObjects = try managedObjectContext.fetch(fetchRequest)
            
            // Vérifiez si un objet a été trouvé
            if let objectToUpdate = fetchedObjects.first {
                
                // Étape 3: Mettre à jour les attributs de l'objet
                objectToUpdate.date = date
                
                // Étape 4: Sauvegarder les modifications
                try managedObjectContext.save()
            } else {
                print("Aucun objet trouvé avec la valeur de recherche spécifiée.")
            }
        } catch {
            print("Erreur lors de la récupération de l'objet: \(error)")
        }
    }
}
