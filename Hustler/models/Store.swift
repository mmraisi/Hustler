//
//  Store.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import Foundation


struct Store{
    var name: String
    var lat: String
    var long: String
    var productsList: [Product]
    
    init(){
        name = "The North Face"
        lat = "43.824724"
        long = "79.536022"
        productsList = [Product]()
    }
    
    
    init(name: String, lat: String, long: String, productsList: [Product]) {
        self.name = name
        self.lat = lat
        self.long = long
        self.productsList = productsList
    }
    
    func fillProducts (){
        // this function will append the store's productsList with all the products
    }
}
