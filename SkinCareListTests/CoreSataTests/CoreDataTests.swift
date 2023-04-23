//
//  CoreDataTests.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import XCTest
import CoreData
@testable import SkinCareList

final class CoreDataTests: XCTestCase {

    var coreDataService: CoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        coreDataService = coreDataService(coreDataStack: coreDataStack)
    }
    
    let productTest1 = Product(init(brands: "Sephora", imageFrontURL: "", productNameFr: "Gloss"))
    
    let productTest2 = Product(brands: "Bioderma", imageFrontURL: "", productNameFr: "Savon"))
}

private var productInList = [Products]()

override func tearDown() {
    super.tearDown()
    coreDataStack = nil
    coreDataService = nil
}
