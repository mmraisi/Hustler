//
//  Order.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

// this struct will be used for the buyer to check their orders,
//and for the hustlers to see the list of orders at their end

struct Order: Identifiable, Codable {
    @DocumentID var id : String? = UUID().uuidString
    var product : Product = Product()
    var customer : Customer = Customer()
    var storeName : String = ""
    var isAccepted: Bool = false
    
    init(){
        
    }
    
    init(id: String? = nil, product: Product, customer: Customer, storeName: String, isAccepted: Bool) {
        self.id = id
        self.product = product
        self.customer = customer
        self.storeName = storeName
        self.isAccepted = isAccepted
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.product = try container.decode(Product.self, forKey: .product)
        self.customer = try container.decode(Customer.self, forKey: .customer)
        self.storeName = try container.decode(String.self, forKey: .storeName)
        self.isAccepted = try container.decode(Bool.self, forKey: .isAccepted)
    }
}
