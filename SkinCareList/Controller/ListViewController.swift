//
//  ListViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 09/03/2023.
//

import UIKit
import CoreData
import Lottie

class ListViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewList: UITableView!
    
    // MARK: - Properties
    
    private let coreDataManager = CoreDataManager()
    private let animationView = LottieAnimationView(name: "113960-cosmetics")
    private var fetchedResultsController: NSFetchedResultsController<Products>!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFetchedResultsController()
        setUpLottieBackgroundView()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableViewList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
    }
    
    private func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "brand", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to fetch products: \(error.localizedDescription)")
        }
    }
    
    private func setUpLottieBackgroundView() {
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.0
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        tableViewList.backgroundView = animationView
    }
    
    private func animateLottieBackgroundView() {
        animationView.play { [weak self] _ in
            self?.animationView.currentProgress = 0
        }
    }
    
    private func configureCell(_ cell: CustomTableViewCell, at indexPath: IndexPath) {
        let product = fetchedResultsController.object(at: indexPath)
        cell.configureCell(withImage: product.image ?? "", brand: product.brand ?? "", type: product.type ?? "", date: product.date ?? "")
        cell.delegate = self
    }
    
    func getDateFromNow() -> String {
        
        let now = Date()
        let french = DateFormatter()
        french.dateStyle = .medium
        french.locale = Locale(identifier: "FR-fr")
        let date = french.string(from: now)
        
        return date
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell,
           let searchTerm = cell.productType.text {
            let webVC = WebViewController()
            webVC.searchTerm = searchTerm
            webVC.modalTransitionStyle = .crossDissolve
            webVC.modalPresentationStyle = .overFullScreen
            self.present(webVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let product = fetchedResultsController.object(at: indexPath)
            coreDataManager.deleteProduct(with: product.code ?? "")
        }
    }
}

// MARK: - CustomTableViewCellDelegate

extension ListViewController: CustomTableViewCellDelegate {
    
    func didTapStartButton(in cell: CustomTableViewCell) {
        
        guard let indexPath = tableViewList.indexPath(for: cell) else { return }
        let product = fetchedResultsController.object(at: indexPath)
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Attention", message: "Tu veux commencer ton produit et enregistrer sa date d'ouverture", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Oui", style: .default, handler: { [self] (action) -> Void in
            coreDataManager.updateDate(with: product.code ?? "", date: getDateFromNow())
            animateLottieBackgroundView()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Non", style: .destructive) { [self] (action) -> Void in
            coreDataManager.updateDate(with: product.code ?? "", date: "")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ListViewController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewList.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableViewList.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableViewList.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath,
               let cell = tableViewList.cellForRow(at: indexPath) as? CustomTableViewCell {
                configureCell(cell, at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableViewList.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableViewList.insertRows(at: [newIndexPath], with: .automatic)
            }
        @unknown default:
            fatalError("Unhandled case in controller(_:didChange:at:for:newIndexPath:)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewList.endUpdates()
    }
}
