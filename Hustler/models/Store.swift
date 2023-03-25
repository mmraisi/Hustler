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
        productsList = [
            Product(id:"1",pName: "Winter Jacket", pDesc: "Our new winter jacket 2023", pPrice: 100.0, pImageURI: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333517662_01_b-The-North-Face-Mens-Cypress-Parka-NF0A5GJXJK3?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520"),
            Product(id:"2",pName: "Winter Boots", pDesc: "Our new winter boots 2023", pPrice: 120.0, pImageURI: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333855870_01_a-The-North-Face-Womens-ThermoBall-Pull-On-Waterproof-Winter-Boots-NF0A5LWER0G?wid=800&hei=800&bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1"),
            Product(id:"3",pName: "Winter beanie", pDesc: "Our new winter beanie 2023", pPrice: 20.0, pImageURI: "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/91V783r2hbL._AC_UL1500_.jpg")
             ]
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
