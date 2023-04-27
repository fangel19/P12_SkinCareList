//
//  CoreDataServiceTests.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 27/04/2023.
//

import CoreData
import XCTest
@testable import SkinCareList

final class CoreDataServiceTests: XCTestCase {
    
    var coreDataService: CoreDataService!
    
    override func setUpWithError() throws {
        self.coreDataService = CoreDataService(testContext: FakeContext.testContext)
    }
    
    override func tearDownWithError() throws {
        self.coreDataService = nil
        super.tearDown()
    }
    
    //MARK: - TestMethods
    
    func testAddProduct() {
        let product = CodeResult(code: "123", product: Product(brands: "Brand", imageFrontURL: "http://image.com", productNameFr: "ProductName")) // Initialize with some data
        
        coreDataService.addProduct(product: product)
        XCTAssertTrue(coreDataService.checkThatItAlreadyExists(sameProduct: product.code))
    }
    
    func testCheckThatItAlreadyExists() {
        let product = CodeResult(code: "123", product: Product(brands: "Brand", imageFrontURL: "http://image.com", productNameFr: "ProductName")) // Initialize with some data
        
        XCTAssertFalse(coreDataService.checkThatItAlreadyExists(sameProduct: product.code))
        coreDataService.addProduct(product: product)
        XCTAssertTrue(coreDataService.checkThatItAlreadyExists(sameProduct: product.code))
    }
    
    func testDeleteProduct() {
        let product = CodeResult(code: "123", product: Product(brands: "Brand", imageFrontURL: "http://image.com", productNameFr: "ProductName")) // Initialize with some data
        
        coreDataService.addProduct(product: product)
        XCTAssertTrue(coreDataService.checkThatItAlreadyExists(sameProduct: product.code))
        
        coreDataService.deleteProduct(with: product.code)
        XCTAssertFalse(coreDataService.checkThatItAlreadyExists(sameProduct: product.code))
    }
    
    func testUpdateDate() {
        let product = CodeResult(code: "123", product: Product(brands: "Brand", imageFrontURL: "http://image.com", productNameFr: "ProductName")) // Initialize with some data
        let updatedDate = "2023-04-27"
        
        coreDataService.addProduct(product: product)
        coreDataService.updateDate(with: product.code, date: updatedDate)
        
        let request: NSFetchRequest = Products.fetchRequest()
        request.predicate = NSPredicate(format: "code LIKE %@", product.code)
        if let products = try? coreDataService.context.fetch(request), let updatedProduct = products.first {
            XCTAssertEqual(updatedProduct.date, updatedDate)
        }
    }
}

