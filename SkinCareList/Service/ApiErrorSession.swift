//
//  ApiErrorSession.swift
//  SkinCareList
//
//  Created by angelique fourny on 15/03/2023.
//

import Foundation
import FileProvider

//MARK: - ERROR
enum APIError: Error {
case decoding
case server
case network
    
    var description : String {
        switch self {
        case APIError.decoding:
            return "Error decoding"
            
        case APIError.network:
            return "Error network"
            
        case APIError.server:
            return "Error server"
        }
    }
}
