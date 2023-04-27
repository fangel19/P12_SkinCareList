//
//  ProductTest.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 27/04/2023.
//

import XCTest
@testable import SkinCareList

final class ProductTest: XCTestCase {
    
    private var product2 = CodeResult(code: "3401528520846", product: Product.init(brands: "String", imageFrontURL: "", productNameFr: ""))
    private var product1 = "3401528520846"
    private var product3 = ProductName(code: "", brands: "", imageFrontURL: "", productNameFr: "")
    //    private var product1 = ProductName(name: "Bioderma")
    private var welcomeController = WelcomeViewController()
    private var scannerController = ScannerViewController()
    
    func testScannProduct() {
        
        scannerController.found(code: product1)
        //        welcomeController.coreDataManager.addProduct(product: product3)
        XCTAssertEqual(welcomeController.scanButton.allTargets.count,  1)
        //        XCTAssertEqual(welcomeController.accessibilityElementCount(), 1)
    }
    
//    func testAddProduct() {
//
//        let bioderma = product2
//        welcomeController.productScanned(product: bioderma)
//        XCTAssertNotNil(bioderma)
//        XCTAssertEqual(bioderma, product2)
//
//    }
    
    func testdeleteProduct() {
        scannerController.found(code: product1)
        welcomeController.coreDataManager.deleteProduct(with: product1)
        XCTAssertEqual(welcomeController.accessibilityElementCount(), 0)
    }
    
    func testMessageShow() {
        
        let alert = welcomeController
        let _ = welcomeController.scanButton.hashValue == 0
        
        XCTAssertTrue(alert.showAlert(title: "Désolé", message: "Le produit n'a pas été trouvé, scanne un nouveau produit.") == alert.showAlert(title: "Désolé", message: "Le produit n'a pas été trouvé, scanne un nouveau produit."))
    }
    
    func testProductWithCodeResult() {
        let product = CodeResult(code: "", product: Product.init(brands: "", imageFrontURL: "", productNameFr: ""))
        XCTAssertEqual(product.code, "")
        XCTAssertEqual(product.product.brands, "")
        XCTAssertEqual(product.product.productNameFr, "")
        XCTAssertEqual(product.product.imageFrontURL, "")
                                 
    }
    
    func testMessageStartProduct() {
        
//        let list = ListViewController()
//        let cell = CustomTableViewCell.self
//        var count = 1
//        cell.start(alert.dialogMessage)
//        count = didTapStartButton(in: cell.start(<#T##self: CustomTableViewCell##CustomTableViewCell#>))
//        count = cell.index(ofAccessibilityElement: count)
//        XCTAssertTrue
    }
    
    func testApiErrorDescriptionErrorIsDecoding() {
        
        let apiError = APIError.decoding
        XCTAssertTrue(apiError.description == "Error decoding")
    }
    
    func testApiErrorDescriptionErrorIsNetwork() {
        
        let apiError = APIError.network
        XCTAssertTrue(apiError.description == "Error network")
    }
    
    func testApiErrorDescriptionErrorIsServer() {
        
        let apiError = APIError.server
        XCTAssertTrue(apiError.description == "Error server")
    }
}
