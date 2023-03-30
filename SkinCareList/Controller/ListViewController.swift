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
            print("=>", product.name)
        }
        print(test!.count)
        
        
    }
}



//    private func updateProduct() {
//        OpenFoodFactsService.shared.getCode(code: productscanne, completion: { results in
//            switch results {
//            case .success(let products):
//                DispatchQueue.main.async {
//                    if !products.product.isEmpty {
//                        self.tableViewList.reloadData()
//                    } else {
//                    }
//                }
//            case . failure(let failure):
//                print("erreur")
//            }
//        })
//    }


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
        cell.configureCell(withImage: product.imageFrontURL, name: product.productNameFr, date: "")
        
        return cell
    }
}
