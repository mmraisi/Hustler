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
    @State private var showNewOrderAlert = false
    @State private var showPending:Bool = false
    @State private var showCompleted:Bool = false
    @State private var showCanceled:Bool = false
    
    var body: some View {
        VStack{
            List {
                DisclosureGroup("Pending Orders :\(self.fireDBHelper.pendingList.count)", isExpanded: $showPending,content:{
                    ForEach(self.fireDBHelper.pendingList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    OrderItemView(order: order)
                                }
                            }
                    }
                }).tint(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                    
                DisclosureGroup("Completed Orders : \(self.fireDBHelper.completedList.count)", isExpanded: $showCompleted,content:{
                    ForEach(self.fireDBHelper.completedList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    OrderItemView(order: order)
                                }
                            }
                    }
                }).tint(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))

                DisclosureGroup("Canceled Orders : \(self.fireDBHelper.canceledList.count)", isExpanded: $showCanceled,content:{
                    ForEach(self.fireDBHelper.canceledList,id: \.id){order in
                            VStack(alignment: .leading){
                                NavigationLink(destination: OrderDetailView(order: order).environmentObject(fireDBHelper)) {
                                    OrderItemView(order: order)
                                }
                            }
                    }
                }).tint(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                .alert(isPresented: $showNewOrderAlert) {
                           Alert(
                               title: Text("New Order Added"),
                               message: Text("A new order has been added."),
                               dismissButton: .default(Text("OK"))
                           )
                       }
            }.onAppear(perform: {
                reset()
                
                self.fireDBHelper.getAllOrders { (orders, error) in
                    if error != nil {
                        // Handle the error
                    } else if let orders = orders {
                        self.fireDBHelper.pendingList = (orders ).filter { !$0.isCanceled && !$0.isAccepted }
                        self.fireDBHelper.completedList = (orders ).filter { !$0.isCanceled && $0.isAccepted }
                        self.fireDBHelper.canceledList = (orders ).filter { $0.isCanceled && !$0.isAccepted }
                    }
                }
            })
            .onReceive(self.fireDBHelper.$pendingList) { newItems in
                if ((newItems.count > self.fireDBHelper.pendingList.count)  && (self.fireDBHelper.pendingList.count != 0)){
                    print("New item added: \(newItems.last!)")
                    showNewOrderAlert = true
                }
            }
        }
        .navigationTitle("Hustler")
        .navigationBarItems(leading: HStack {
            Image(systemName: "person.circle.fill")
                .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
            Text((Auth.auth().currentUser?.email)!)
                                .font(.headline)
                                .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
            
        },trailing: HStack{
            
            Button(action: {
                rootScreen = .Login
            }){
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
            }
        })
    }
    func reset(){
        self.fireDBHelper.pendingList = [Order]()
        self.fireDBHelper.completedList = [Order]()
        self.fireDBHelper.canceledList = [Order]()
    }
    
    
}
