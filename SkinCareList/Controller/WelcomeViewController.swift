//
//  WelcomeViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit

class WelcomeViewController: UIViewController, ScannerViewControllerDelegate {
    
    //MARK: - Properties
    
    var coreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.sharedInstance.viewContext)
    
    lazy var scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Rond_scan"), for: .normal)
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupLayoutConstraints()
    }

    private func setupSubview() {
        self.view.addSubview(self.scanButton)
    }
    
    //MARK: - Method
    
    private func setupLayoutConstraints() {
        let buttonHorizontalConstraint = scanButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let buttonVerticalConstraint = scanButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let buttonHeightConstraint = scanButton.heightAnchor.constraint(equalToConstant: 300.0)
        let buttonWidthConstraint = scanButton.widthAnchor.constraint(equalToConstant: 300.0)
        
        NSLayoutConstraint.activate([buttonHorizontalConstraint, buttonVerticalConstraint, buttonWidthConstraint, buttonHeightConstraint])
    }
    
    @objc func scanButtonTapped() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scanVC = storyboard.instantiateViewController(withIdentifier: "CodeVC") as! ScannerViewController
        scanVC.delegate = self
        self.present(scanVC, animated: true)
    }
    
    func productScanned(product: CodeResult) {
        self.coreDataManager.addProduct(product: product)
    }
    
    func productScannedFailed(error: Error) {
        showAlert(title: "Désolé", message: "Le produit n'a pas été trouvé, scanne un nouveau produit.")
    }
}
