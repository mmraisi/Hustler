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
            Product(id:"1",pName: "Hydrenalite Down Hoodie", pDesc: "The water-repellent Hydrenalite Down Hoodie pairs city style with expedition-tested features like 550-fill Down baffles and an insulated hood to keep the iciest winds at bay.", pPrice: 299.99, pImageURI: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333517662_01_b-The-North-Face-Mens-Cypress-Parka-NF0A5GJXJK3?bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1&hei=520"),
            Product(id:"2",pName: "ThermoBall Waterproof Booties", pDesc: "Stay warm, dry, and comfortable on city adventures with the ThermoBall™ Progressive Zip II Waterproof.", pPrice: 174.99, pImageURI: "https://fgl.scene7.com/is/image/FGLSportsLtd/FGL_333855870_01_a-The-North-Face-Womens-ThermoBall-Pull-On-Waterproof-Winter-Boots-NF0A5LWER0G?wid=800&hei=800&bgColor=0,0,0,0&resMode=sharp2&op_sharpen=1"),
            Product(id:"3",pName: "Box Cuffed Regular Beanie", pDesc: "Tame the most unruly mops with the TNF™ Logo Box Cuffed Beanie, a rib-knit hat with soft yarn for added stretch, comfort, and style.", pPrice: 34.99, pImageURI: "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/91V783r2hbL._AC_UL1500_.jpg"),
            
            Product(id:"4",pName: "Borealis Backpack", pDesc: "Our classic Borealis Backpack is a staple on campus and on the trail. Designed with an external bungee storage system, protective laptop compartment, and simplified internal organization, this pack can take you anywhere.", pPrice: 99.00, pImageURI: "https://images.thenorthface.com/is/image/TheNorthFace/NF0A52SE_RK2_hero?wid=1300&hei=1510&fmt=jpeg&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"),
            
            Product(id:"5",pName: "Men’s ’92 Low-Fi Hi-Tek Nuptse", pDesc: "The Men’s ’92 Low-Fi Hi-Tek Nuptse combines a retro ’90s aesthetic with technical WindWall™ fabrics, 700-fill down insulation, and water-repellent cotton.", pPrice: 360.00, pImageURI: "https://images.thenorthface.com/is/image/TheNorthFace/NF0A7ZYP_TV8_modelhood1?wid=1300&hei=1510&fmt=jpeg&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0")
             ]
    }
    
    
    init(name: String, lat: String, long: String, productsList: [Product]) {
        self.name = name
        self.lat = lat
        self.long = long
        self.productsList = productsList
    }
    
}
