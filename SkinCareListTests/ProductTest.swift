//
//  ProductTest.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 27/04/2023.
//

import XCTest
import CoreData
@testable import SkinCareList

final class ProductTest: XCTestCase {
    
    private var product1 = "3401528520846"
    private var welcomeController: WelcomeViewController!
    private var scannerController: ScannerViewController!
    
    var coreDataService: CoreDataService!
    
    override func setUpWithError() throws {
        self.coreDataService = CoreDataService(testContext: FakeContext.testContext)
        self.welcomeController = WelcomeViewController()
        self.scannerController = ScannerViewController()
    }
    
    override func tearDownWithError() throws {
        self.coreDataService = nil
        self.welcomeController = nil
        self.scannerController = nil
        super.tearDown()
    }
    
    func testScannProduct() {
        
        scannerController.found(code: product1)
        
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "code LIKE %@", self.product1)
        if let products = try? coreDataService.context.fetch(request), let updatedProduct = products.first {
            XCTAssertEqual(product1, updatedProduct.code)
        }
    }
}
