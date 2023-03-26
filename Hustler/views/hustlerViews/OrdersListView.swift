//
//  OrdersListView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import Firebase

struct OrdersListView: View {
    @EnvironmentObject var dataSource: DataSoruce
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @Binding var rootScreen :RootView
    
    var body: some View {
        VStack{
            List {
                Section(header: Text("Pending")) {
                    ForEach(self.fireDBHelper.pendingList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    ProductItem(product: order.product)
                                }
                            }//VStack
                    }
                }
                
                Section(header: Text("Completed")) {
                    ForEach(self.fireDBHelper.completedList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    ProductItem(product: order.product)
                                }
                            }//VStack
                    }
                }
                
                Section(header: Text("Canceled")) {
                    ForEach(self.fireDBHelper.canceledList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    ProductItem(product: order.product)
                                }
                            }//VStack
                    }
                    
                }
            }.onAppear(perform: {
//                reset()
                self.fireDBHelper.getAllPendingOrder { (orders, error) in
                    if error != nil {
                        // handle error
                        return
                    }
                    
                    // use the array of orders
                    print("Retrieved \(orders?.count ?? 0) pending orders")
                    self.fireDBHelper.pendingList = orders ?? [Order]()
                }
                self.fireDBHelper.getAllCanceledOrder { (orders, error) in
                    if error != nil {
                        // handle error
                        return
                    }
                    
                    // use the array of orders
                    print("Retrieved \(orders?.count ?? 0) canceled orders")
                    self.fireDBHelper.canceledList = orders ?? [Order]()
                }
                
                self.fireDBHelper.getAllCompletedOrder { (orders, error) in
                    if error != nil {
                        // handle error
                        return
                    }
                    
                    // use the array of orders
                    print("Retrieved \(orders?.count ?? 0) completed orders")
                    self.fireDBHelper.completedList = orders ?? [Order]()
                }
                
            })
            
        }
        .navigationTitle("Hustler")
        .navigationBarItems(leading: HStack {
            Image(systemName: "person.circle.fill")
            Text((Auth.auth().currentUser?.email)!)
                                .font(.headline)
            
        },trailing: HStack{
            
            Button(action: {
                rootScreen = .Login
            }){
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(Color.black)
            }
        })
    }
    func reset(){
        self.fireDBHelper.pendingList = [Order]()
        self.fireDBHelper.completedList = [Order]()
        self.fireDBHelper.canceledList = [Order]()
    }
    
    
}

//struct OrdersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrdersListView()
//    }
//}
