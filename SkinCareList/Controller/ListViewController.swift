//
//  ListViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit
import CoreData
import SwiftUI
import Lottie

class ListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableViewList: UITableView!
    
    //MARK: - Properties
    
    private var productResult = [Products]()
    let coreDataManager = CoreDataManager()
    private let animationView = LottieAnimationView(name: "113960-cosmetics")
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateProduct()
        tableViewList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
        self.setUpLottieBackgroundView()
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
            print("=>", product.brand as Any)
            productResult.append(product)
        }
        
        print(test!.count)
        tableViewList.reloadData()
    }
    
    func setUpLottieBackgroundView() {
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.0 // Ajustez la vitesse d'animation
        animationView.loopMode = .playOnce // Ajustez le mode de boucle
        animationView.backgroundBehavior = .pauseAndRestore
        tableViewList.backgroundView = animationView
    }
    
    func animateLottieBackgroundView() {
        animationView.play { [weak self] _ in
            self?.animationView.currentProgress = 0
        }
    }

    //MARK: - Core
    
    private func completeProductsArray(product: Product) -> [ProductArray] {
        var productArray = [ProductArray]()
        
        let products = ProductArray(
            productbrands: product.brands,
            producttype: product.productNameFr,
            productImage: product.imageFrontURL)
        
        productArray.append(products)
        
        return productArray
    }
    
    func getDateFromNow() -> String {
        
        let now = Date()
        let french = DateFormatter()
        french.dateStyle = .medium
        french.locale = Locale(identifier: "FR-fr")
        let date = french.string(from: now)
        print(french.string(from: now))
        
        return date
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
        cell.configureCell(withImage: product.image ?? "", brand: product.brand ?? "", type: product.type ?? "", date: product.date ?? "")
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let code = self.productResult[indexPath.row].code else { return }
            coreDataManager.deleteProduct(with: code)
            productResult.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ListViewController: CustomTableViewCellDelegate {
    
    func didTapStartButton(in cell: CustomTableViewCell) {
        
        guard let indexPath = tableViewList.indexPath(for: cell) else { return }
        guard let code = self.productResult[indexPath.row].code else { return }
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Attention", message: "Tu veux commencer ton produit et enregistrer sa date d'ouverture", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Oui", style: .default, handler: { [self] (action) -> Void in
            print("Ok button tapped")
            coreDataManager.updateDate(with: code, date: getDateFromNow())
            tableViewList.reloadData()
            self.animateLottieBackgroundView()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Non", style: .destructive) { [self] (action) -> Void in
            print("Cancel button tapped")
            coreDataManager.updateDate(with: code, date: "")
            tableViewList.reloadData()
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
