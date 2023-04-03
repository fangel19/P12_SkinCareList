//
//  CustomTableViewCell.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "customTableViewCell"
    
    //MARK: - Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDate: UILabel!
    @IBOutlet weak var productType: UILabel!
    
    //MARK: - Action
    
    @IBAction func start(_ sender: Any) {
        let now = Date()
        let french = DateFormatter()
        french.dateStyle = .medium
        french.locale = Locale(identifier: "FR-fr")
        print(french.string(from: now))
    }
    
    func configureCell(withImage imageFront: String, brand: String, type: String, date: String) {
        
        productImage.downloaded(from: imageFront)
        productDate.text = date
        productName.text = brand
        productType.text = type
    }
}
