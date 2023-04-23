//
//  UIViewController+Alert.swift
//  SkinCareList
//
//  Created by angelique fourny on 23/04/2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String = "OK") {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
            
            self.present(alertController, animated: true)
        }
    }
}

