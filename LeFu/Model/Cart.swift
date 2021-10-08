//
//  Cart.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import CoreData

public class Cart: NSManagedObject {
    
    static var current: Cart {
        let context = AppDelegate.viewContext
        
        let cartFetchRequest = Cart.fetchRequest()
        cartFetchRequest.fetchLimit = 1
        
        var cart: Cart?
        
        if let result = try? context.fetch(cartFetchRequest) {
            cart = result.first
        }
        
        if cart == nil {
            if let description = NSEntityDescription.entity(forEntityName: "Cart", in: context) {
                cart = Cart(entity: description, insertInto: context)
                try? context.save()
            }
        }
        
        return cart!
    }
    
    public override func willSave() {
        if self.totalCount != Int32(self.items?.count ?? 0) {
            self.totalCount = Int32(self.items?.count ?? 0)
            self.totalPrice = self.items?
                .map({$0 as! CartItem})
                .map({$0.price})
                .reduce(0, +) ?? 0
        }
    }
    
}
