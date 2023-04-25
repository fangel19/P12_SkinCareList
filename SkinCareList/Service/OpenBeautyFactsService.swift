//
//  OpenFoodFactsService.swift
//  SkinCareList
//
//  Created by angelique fourny on 15/03/2023.
//

import Foundation
import Alamofire

class OpenBeautyFactsService {
    
    //MARK: - Singleton
    
    static let shared = OpenBeautyFactsService(session: Alamofire.Session(configuration: .default))
    
    private let session: Alamofire.Session
    init(session: Alamofire.Session){
        self.session = session
    }
    
    //MARK: - Method
    func getCode(code : String, completion: @escaping (Result<CodeResult, APIError>)-> Void) {
        session.request("https://ssl-api.openbeautyfacts.org/api/v0/product/\(code)")
            .validate(statusCode: 200..<300)
            .responseData { response in
                print(response.response?.statusCode as Any, response.request?.url as Any)
                switch response.result {
                case .success(let product):
                    print("Validation Successful")
                    
                    switch response.response?.statusCode {
                    case 200:
                        print(product)
                        
                        do {
                            let codeProduct = try JSONDecoder().decode(CodeResult.self, from: product)
                            completion(.success(codeProduct))
                            
                        } catch {
                            completion(.failure(.decoding))
                        }
                        
                    case 404:
                        completion(.failure(.network))
                        
                    case 500:
                        completion(.failure(.server))
                        
                    default:
                        completion(.failure(.decoding))
                    }
                case .failure(_):
                    completion(.failure(.server))
                }
            }
    }
}
