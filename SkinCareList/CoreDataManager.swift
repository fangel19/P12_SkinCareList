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
//        if !checkThatItAlreadyExists(sameProduct: product.code) == false {
//            let entity = Products(context: managedObjectContext)
//            entity.brand = product.product.brands
//            entity.image = product.product.imageFrontURL
//    //        entity.date = Date
//            entity.type = product.product.productNameFr
//            entity.code = product.code
//
//            print("= toto", checkThatItAlreadyExists(sameProduct: product.code)
//    )
//
//            CoreDataStack.sharedInstance.saveContext()
//        } else {
//            print("existe deja")
//        }
        
        guard !checkThatItAlreadyExists(sameProduct: product.code) else {return}

        let entity = Products(context: managedObjectContext)
        entity.brand = product.product.brands
        entity.image = product.product.imageFrontURL
//        entity.date = Date
        entity.type = product.product.productNameFr
        entity.code = product.code

        print("= toto", checkThatItAlreadyExists(sameProduct: product.code)
)

        CoreDataStack.sharedInstance.saveContext()
    }
    
    func checkThatItAlreadyExists(sameProduct: String) -> Bool {
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "code LIKE %@", sameProduct)
        let products = try? managedObjectContext.fetch(request)
        if products!.isEmpty { return false }
        return true
        
    }
    
    func deleteProduct(row : Int, array : [Products]) {
        for _ in array {
            managedObjectContext.delete(array[row])
            do {
                try managedObjectContext.save()
            } catch {
                print("Error While Deleting : \(error.localizedDescription)")
            }
        }
    }
}
