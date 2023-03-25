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
    
    //MARK: - Action
    
    @IBAction func start(_ sender: Any) {
        let now = Date()
        let french = DateFormatter()
        french.dateStyle = .medium
        french.locale = Locale(identifier: "FR-fr")
        print(french.string(from: now))
    }
    
    func configureCell(withImage imageFront: String, name: String, date: String) {
        productImage
        productDate.text = date
        productName.text = name
    }
}
