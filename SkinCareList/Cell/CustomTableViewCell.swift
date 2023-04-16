//
//  CustomTableViewCell.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit
protocol CustomTableViewCellDelegate: AnyObject {
    
    func didTapStartButton(in cell: CustomTableViewCell)
    
}

class CustomTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "customTableViewCell"
    
    weak var delegate: CustomTableViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDate: UILabel!
    @IBOutlet weak var productType: UILabel!
    
    //MARK: - Action
    
    @IBAction func start(_ sender: Any) {
        
        delegate?.didTapStartButton(in: self)
    }
    
    func configureCell(withImage imageFront: String, brand: String, type: String, date: String) {
        
        productImage.downloaded(from: imageFront)
        productDate.text = date
        productName.text = brand
        productType.text = type
    }
}
