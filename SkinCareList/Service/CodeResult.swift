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
    let ingredientsTextWithAllergensFr: String
    let imageIngredientsURL: String
    let productNameFr: String

    enum CodingKeys: String, CodingKey {
        case brands
        case imageFrontURL = "image_front_url"
        case ingredientsTextWithAllergensFr = "ingredients_text_with_allergens_fr"
        case imageIngredientsURL = "image_ingredients_url"
        case productNameFr = "product_name_fr"
    }
}
