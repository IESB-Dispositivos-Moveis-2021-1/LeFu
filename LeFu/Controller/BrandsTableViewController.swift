//
//  BrandsTableViewController.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import UIKit

class BrandsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Product.brands.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath)
        cell.textLabel?.text = Product.brands[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "onBRandSegue", sender: Product.brands[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onBRandSegue" {
            let destination = segue.destination as? ProductTableViewController
            destination?.brand = sender as? String
        }
    }

}
