//
//  OrderDetailView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import URLImage

struct OrderDetailView: View {
    var order: Order
    @State private var showCartSheet = false
    @EnvironmentObject var dataSource: DataSoruce
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            
            Text("Order Details").font(.title).foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow))).frame(alignment: .center)
            HStack(spacing:10){
                VStack{
                    URLImage(URL(string: order.product.pImageURI)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    }.frame(alignment: .center)
                }
                .padding(.horizontal)
                
                Form{
                    Section(header: Text("Product Information")){
                        Text("Name: \(order.product.pName)").font(.caption)
                        if let orderId = order.id {
                            let truncatedId = String(orderId.prefix(8))
                            Text("Ref: \(truncatedId)").font(.caption)
                        }
                        Text("Price: $\(order.product.pPrice,specifier: "%.2f")").font(.caption)
                    }
                    Section(header:Text("Customer Info")){
                        Text("Name: \(order.customer.cName)").font(.caption)
                        Text("Address: \(order.customer.cAddress)").font(.caption)
                        Text("Email: \(order.customer.cEmail)").font(.caption)
                    }
                }
                Spacer()
            }
            .frame(height: 400)
            
            HStack{
                if(order.isAccepted){
                    Button(action: {
                        cancelOrder()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel Order")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                else if (order.isCanceled){
                    Button(action: {
                        confirmOrder()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Confirm Order")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                else{
                    Button(action: {
                        confirmOrder()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Confirm Order")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        cancelOrder()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel Order")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
            
            
            
        }.frame(height: 500)
    }
    
    private func confirmOrder(){
        var orderToUpdate = order
        orderToUpdate.isCanceled = false
        orderToUpdate.isAccepted = true
        self.fireDBHelper.updateOrder(orderToUpdate: orderToUpdate) { error in
            if let error = error {
                // Handle the error here
                print("Error updating order: \(error.localizedDescription)")
            } else {
                // Handle success
                print("Order updated successfully!")
            }
        }

    }
    private func cancelOrder(){
        var orderToUpdate = order
        orderToUpdate.isCanceled = true
        orderToUpdate.isAccepted = false
        self.fireDBHelper.updateOrder(orderToUpdate: orderToUpdate) { error in
            if let error = error {
                // Handle the error here
                print("Error updating order: \(error.localizedDescription)")
            } else {
                // Handle success
                print("Order updated successfully!")
            }
        }

        
    }
    
}


//struct OrderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderDetailView()
//    }
//}
