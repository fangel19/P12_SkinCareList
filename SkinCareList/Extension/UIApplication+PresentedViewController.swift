//
//  UIViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 23/04/2023.
//

import UIKit

extension UIApplication {
    
    func topMostViewController(controller: UIViewController? = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabBarController = controller as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topMostViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topMostViewController(controller: presented)
        }
        
        return controller
    }
}
