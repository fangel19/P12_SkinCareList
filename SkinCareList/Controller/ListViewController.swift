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
    
    private var productResult = [Products]()
    let coreDataManager = CoreDataManager()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateProduct()
        // Do any additional setup after loading the view.
        tableViewList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        productResult.removeAll()
        loadingProduct()
    }
    
    //MARK: - Method
    
    func loadingProduct() {
        let request: NSFetchRequest = Products.fetchRequest()
        
        let test = try? CoreDataStack.sharedInstance.viewContext.fetch(request)
        
        for product in test! {
            print("=>", product.brand)
            productResult.append(product)
        }
        
        print(test!.count)
        tableViewList.reloadData()
    }
    
    //MARK: - Core
    
    private func completeProductsArray(product: Product) -> [ProductArray] {
        var productArray = [ProductArray]()
        
        let products = ProductArray(
            productbrands: product.brands,
            producttype: product.productNameFr,
            productImage: product.imageFrontURL)
        //            productDate: "")
        
        productArray.append(products)
        
        return productArray
    }
}

//MARK: - TableView

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
        
        let product: Products = self.productResult[indexPath.row]
        cell.configureCell(withImage: product.image ?? "", brand: product.brand ?? "", type: product.type ?? "", date: "")
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            coreDataManager.deleteProduct(row: indexPath.row, array: productResult)
            productResult.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ListViewController: CustomTableViewCellDelegate {
    
    func didTapStartButton(in cell: CustomTableViewCell) {
        guard let indexPath = tableViewList.indexPath(for: cell) else { return }
        print("buttonTapped in cell at row \(indexPath.row), \(self.productResult[indexPath.row].brand)")
    }
}
