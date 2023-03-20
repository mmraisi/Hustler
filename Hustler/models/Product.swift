//
//  Product.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable, Hashable{
    @DocumentID var id :String? = UUID().uuidString
    var pName : String = ""
    var pDesc : String = ""
    var pPrice : Double = 0.0
    var pImageURI : String = ""
    
    
    init(){
        
    }
    
    init(id: String? = nil, pName: String, pDesc: String, pPrice: Double, pImageURI: String) {
        self.id = id
        self.pName = pName
        self.pDesc = pDesc
        self.pPrice = pPrice
        self.pImageURI = pImageURI
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.pName = try container.decode(String.self, forKey: .pName)
        self.pDesc = try container.decode(String.self, forKey: .pDesc)
        self.pPrice = try container.decode(Double.self, forKey: .pPrice)
        self.pImageURI = try container.decode(String.self, forKey: .pImageURI)
    }
    
    
    init?(dictionary: [String:Any]){
        
        guard let name = dictionary["pName"] as? String else {
         print("unable to read title")
            return nil
        }
        
        guard let desc = dictionary["pDesc"] as? String else {
         print("unable to read author")
            return nil
        }
        guard let price = dictionary["pPrice"] as? Double else {
         print("unable to read price")
            return nil
        }
        guard let image = dictionary["pImage"] as? String else {
         print("unable to read image")
            return nil
        }
        
            self.init(pName: name, pDesc: desc, pPrice: price, pImageURI: image)
        }
    
    
    
}
