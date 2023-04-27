//
//  CodeResult.swift
//  SkinCareList
//
//  Created by angelique fourny on 15/03/2023.
//

import Foundation

// MARK: - CodeResult
struct CodeResult: Decodable {
    var code: String
    var product: Product
}

// MARK: - Product
struct Product: Decodable {
    
    let brands: String
    let imageFrontURL: String
    let productNameFr: String
    
    enum CodingKeys: String, CodingKey {
        case brands
        case imageFrontURL = "image_front_url"
        case productNameFr = "product_name_fr"
    }
}
