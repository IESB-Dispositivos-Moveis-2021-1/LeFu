//
//  CartTableViewController.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import UIKit
import CoreData

class CartTableViewController: UITableViewController {
    
    private var fetchtedResultsController: NSFetchedResultsController<CartItem>? {
        didSet {
            fetchtedResultsController?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCartItems()
    }
    
    private func loadCartItems() {
        
        let cart = Cart.current
        let fetchRequest = NSFetchRequest<CartItem>(entityName: "CartItem")
        fetchRequest.predicate = NSPredicate(format: "cart = %@", cart)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchtedResultsController = NSFetchedResultsController<CartItem>(
            fetchRequest: fetchRequest,
            managedObjectContext: AppDelegate.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        try? fetchtedResultsController?.performFetch()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchtedResultsController?.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchtedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItemCell", for: indexPath)
        
        let item = fetchtedResultsController?.object(at: indexPath)
        cell.textLabel?.text = item?.name
        
        return cell
    }

}

extension CartTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        switch type {
            case .insert:
                tableView.insertSections([sectionIndex], with: .bottom)
            case .delete:
                tableView.deleteSections([sectionIndex], with: .bottom)
            case .update:
                tableView.reloadSections([sectionIndex], with: .automatic)
            default:
                break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .left)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .left)
            case .update:
                tableView.reloadRows(at: [indexPath!], with: .middle)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
            @unknown default:
                break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
