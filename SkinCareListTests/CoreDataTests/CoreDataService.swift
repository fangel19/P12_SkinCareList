//
//  CoreDataTests.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import CoreData
@testable import SkinCareList

final class CoreDataService {
    
    private var manager: CoreDataManager
    let context: NSManagedObjectContext
    
    //MARK: - Initializer
    
    init(testContext: NSManagedObjectContext) {
        self.context = testContext
        self.manager = CoreDataManager(managedObjectContext: testContext)
    }
    
    //MARK: - Methods
    
    func addProduct(product: CodeResult) {
        self.manager.addProduct(product: product)
    }
    
    func checkThatItAlreadyExists(sameProduct: String) -> Bool {
        return self.manager.checkThatItAlreadyExists(sameProduct: sameProduct)
    }
    
    func deleteProduct(with code: String) {
        self.manager.deleteProduct(with: code)
    }
    
    func updateDate(with searchValue: String, date: String) {
        self.manager.updateDate(with: searchValue, date: date)
    }
}
