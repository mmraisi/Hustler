//
//  OrdersHistoryView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import Firebase
import URLImage

struct OrdersHistoryView: View {
    @EnvironmentObject var  fireDBHelper : FireDBHelper
    
    var body: some View {
        VStack{
            List {
                Section(header: Text("Pending")) {
                    ForEach(self.fireDBHelper.pendingList,id: \.id){order in
                            VStack(alignment: .leading){
                                ProductItem(product: order.product)
                            }//VStack
                    }
                }
                
                Section(header: Text("Completed")) {
                    ForEach(self.fireDBHelper.completedList,id: \.id){order in
                            VStack(alignment: .leading){
                                ProductItem(product: order.product)
                            }//VStack
                    }
                }
                
                Section(header: Text("Canceled")) {
                    ForEach(self.fireDBHelper.canceledList,id: \.id){order in
                            VStack(alignment: .leading){
                                ProductItem(product: order.product)
                            }//VStack
                    }
                    
                }
            }.onAppear(perform: {
                self.fireDBHelper.reset()
                self.fireDBHelper.getAllOrders { (orders, error) in
                    if let error = error {
                        print("Failed to retrieve pending orders: \(error)")
                        return
                    }
                    
                    // use the array of orders
                    print("Retrieved \(orders?.count ?? 0) orders")
                    self.fireDBHelper.pendingList = (orders ?? [Order]()).filter { !$0.isCanceled && !$0.isAccepted && $0.customer.cEmail == Auth.auth().currentUser?.email}
                    self.fireDBHelper.completedList = (orders ?? [Order]()).filter { !$0.isCanceled && $0.isAccepted && $0.customer.cEmail == Auth.auth().currentUser?.email}
                    self.fireDBHelper.canceledList = (orders ?? [Order]()).filter { $0.isCanceled && !$0.isAccepted && $0.customer.cEmail == Auth.auth().currentUser?.email}
                }
            })
            
        }
    }
}


