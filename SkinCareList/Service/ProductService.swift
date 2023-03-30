//
//  ProductService.swift
//  SkinCareList
//
//  Created by angelique fourny on 30/03/2023.
//

import Foundation

class ProductService {
    
    static let shared = ProductService()
    
    var productscann: [ProductScann] = []
    
    func add(scann: ProductScann) {
        productscann.append(scann)
    }
}
