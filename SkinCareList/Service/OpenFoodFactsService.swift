//
//  OpenFoodFactsService.swift
//  SkinCareList
//
//  Created by angelique fourny on 15/03/2023.
//

import Foundation
import Alamofire

class OpenFoodFactsService {
    
    //MARK: - Singleton
    
    static let shared = OpenFoodFactsService(session: Alamofire.Session(configuration: .default))
    
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
                    //                    let json = try? JSONSerialization.jsonObject(with: product, options: [.allowFragments])
                    //                    print(json)
                    switch response.response?.statusCode {
                    case 200:
                        print(product)
                        guard let codeProduct = try? JSONDecoder().decode(CodeResult.self, from: product) else { return }
                        completion(.success(codeProduct))
                        
                        
                        //                        do {
                        //                            let codeProduct = try JSONDecoder().decode(CodeResult.self, from: product)
                        //
                        //                        } catch let error {
                        //                            print(error.localizedDescription)
                        //                        }
                        //                        completion(.success(codeProduct))
                        
                        
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
