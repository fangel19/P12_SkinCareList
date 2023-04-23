//
//  CoreDataTests.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import XCTest
import CoreData
import SwiftUI
@testable import SkinCareList

final class CoreDataTests: XCTestCase {
    
    var coreDataService: CoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
    }
    
    
    let product1 = CodeResult(code: "", product: Product(brands: "Sephora", imageFrontURL: "", productNameFr: "Gloss"))

    let product2 = CodeResult(code: "", product: Product(brands: "Bioderma", imageFrontURL: "", productNameFr: "Savon"))
    
                              
    private var productInList = [Products]()
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataService = nil
    }
}