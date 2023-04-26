//
//  FakeResponseData.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 26/04/2023.
//

import Foundation

class FakeResponseData {
    
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
   
    
    // MARK: - Data
    
    static var productCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Product", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur" .data(using: .utf8)!
    
    // MARK: - Error
         
     class ConversionError: Error {}
     
     static let conversionError = ConversionError()
}
