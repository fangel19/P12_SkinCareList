//
//  AlertMessage.swift
//  SkinCareList
//
//  Created by angelique fourny on 30/03/2023.
//

import Foundation

class AlertMessage: Error {
    
    var title = String()
    var body = String()
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
