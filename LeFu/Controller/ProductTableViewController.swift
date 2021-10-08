//
//  ProductTableViewController.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import UIKit

class ProductTableViewController: UITableViewController {
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    var brand: String? {
        didSet {
            if let brand = brand {
                fetchProducts(for: brand)
            }
        }
    }
    
    private var products = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var session = URLSession(configuration: URLSessionConfiguration.default,
                                          delegate: self,
                                          delegateQueue: OperationQueue.main)
    
    private func fetchProducts(for brand: String) {
        let url = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=\(brand)"
        let task = session.dataTask(with: URL(string: url)!)
        task.resume()
        navigationItem.title = brand
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        let product = products[indexPath.row]
        cell.setup(with: product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        
        let context = AppDelegate.viewContext
        
        let cartItem = CartItem(context: context)
        cartItem.name = product.name
        cartItem.price = NumberFormatter().number(from: product.price ?? "0")?.doubleValue ?? 0
        cartItem.count = 1
        cartItem.cart = Cart.current
        
        try? context.save()

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

extension ProductTableViewController: URLSessionDataDelegate {
 
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200 && response.statusCode < 300 {
            
            if let products = try? JSONDecoder().decode([Product].self, from: data) {
                self.products.removeAll()
                self.products.append(contentsOf: products)
            }
        }
    }
    
}
