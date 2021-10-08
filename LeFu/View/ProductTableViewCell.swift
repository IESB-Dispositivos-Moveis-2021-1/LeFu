//
//  ProductTableViewCell.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {


    @IBOutlet weak var productImageViewActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    
    func setup(with product: Product) {
        productName.text = product.name
        productPrice.text = "\(product.priceSign ?? "$") \(product.price ?? "0")"
        
        
        if let imageLink = product.imageLink, let url = URL(string: imageLink) {
            productImageViewActivityIndicator.startAnimating()
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        self?.productImageView.image = UIImage(data: data)
                        self?.productImageViewActivityIndicator.stopAnimating()
                    }
                }
            }
        }
        
    }
    
}
