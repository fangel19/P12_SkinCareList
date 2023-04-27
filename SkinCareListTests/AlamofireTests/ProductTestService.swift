//
//  ProductTestService.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 26/04/2023.
//

import XCTest
import Alamofire
@testable import SkinCareList

final class ProductTestService: XCTestCase {
    
    var productService: OpenBeautyFactsService!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [URLTest.self] + (configuration.protocolClasses ?? [])
        let session = Alamofire.Session(configuration: configuration)
        productService = OpenBeautyFactsService(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        productService = nil
    }
    
    private var welcomeViewController = WelcomeViewController()
    
    func testProductResponseKOErrorFakeResponseDataNil() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.networkError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Result has arrived")
        productService.getCode(code: "3401528520846") { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("error status")
                return
            }
            XCTAssertNotNil(error)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
    }
    
    func testProductResponseOKErrorNilDataIncorrect() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        productService.getCode(code: "3401528520846") { (result) in
            
            guard case .success(let product) = result else {
                XCTFail("error status")
                return
            }
            let list = product.code
            XCTAssertNotNil(list)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
    }
    
    func testProductResponseKOErrorNilDataIncorrect() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let alert = welcomeViewController
        let expectation = XCTestExpectation(description: "Wait for queue change")
        productService.getCode(code: "3564706551268") { (result) in
            
            guard case .failure = result else { return }
            XCTAssertTrue(alert.showAlert(title: "Désolé", message: "Le produit n'a pas été trouvé, scanne un nouveau produit.") == alert.showAlert(title: "Désolé", message: "Le produit n'a pas été trouvé, scanne un nouveau produit."))
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
    }
    
    func testShouldGetProduct() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.productCorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        productService.getCode(code: "3401528520846") { (result) in
            
            guard case .success(let productInfo) = result else {
                XCTFail("error status")
                return
            }
            XCTAssertEqual(productInfo.product.brands, "Bioderma")
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
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
