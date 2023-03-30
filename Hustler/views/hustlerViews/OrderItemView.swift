//
//  OrderItemView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 27/03/2023.
//

import SwiftUI
import URLImage

struct OrderItemView: View {
    // the following is the custom list Item
    var  order : Order
    
    var body: some View {
        
        HStack {
            URLImage(URL(string: order.product.pImageURI)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("\(order.customer.cEmail)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                Text(order.product.pName)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Price: $\(String(format: "%.2f", order.product.pPrice))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

//struct OrderItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderItemView()
//    }
//}
