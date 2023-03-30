//
//  WelcomeViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Rond_scan"), for: .normal)
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupLayoutConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setupSubview() {
        self.view.addSubview(self.scanButton)
    }
    
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
        
        self.present(scanVC, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
