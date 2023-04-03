//
//  ListViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableViewList: UITableView!
    
    //MARK: - Properties
    
    private var productResult = [Product]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateProduct()
        // Do any additional setup after loading the view.
        tableViewList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
        
        let request: NSFetchRequest = Products.fetchRequest()
        
        let test = try? CoreDataStack.sharedInstance.viewContext.fetch(request)
        
        for product in test! {
            print("=>", product.brand)
        }
        print(test!.count)
        
        
    }
    
    //MARK: - Core
    
//    private func completeProductsArray(codeResult: CodeResult) -> [ProductArray] {
//        var productArray = [ProductArray]()
//
//        codeResult.code.forEach() { product in
//            let product = ProductArray(
//                brands: product.product.brands,
//                imageFrontURL: product.product.imageFrontURL,
//                productNameFr: product.product.productNameFr)
//
//            productArray.append(product)
//        }
//        return productArray
//    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewList.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomTableViewCell else {
            
            return UITableViewCell()
        }
        
        let product: Product = self.productResult[indexPath.row]
        cell.configureCell(withImage: product.imageFrontURL, brand: product.brands, type: product.productNameFr, date: "")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
