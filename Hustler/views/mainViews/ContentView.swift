//
//  ContentView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import Firebase


// this view will be showing:
//the tab view for the buyer (ProductsListViw/OrdersHistoryView)
//or will have one view for the hustler (OrdersListView-> OrddeDetialView)

struct ContentView: View {
    @EnvironmentObject var dataSource: DataSoruce
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @Binding var rootScreen :RootView

    
    var body: some View {
        VStack{
            TabView {
                ProductsListView().environmentObject(fireDBHelper)
                    .tabItem {
                        Label("Products", systemImage: "list.dash")
                    }
                
                OrdersHistoryView().environmentObject(fireDBHelper)
                    .tabItem {
                        Label("Order History", systemImage: "clock")
                    }.badge(fireDBHelper.pendingList.count)
            }
            .onAppear(perform: {
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
            .accentColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
            .navigationTitle("Hustler")
            .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
            .navigationBarItems(leading: HStack {
                Image(systemName: "person.circle.fill").foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                Text((Auth.auth().currentUser?.email)!)
                                    .font(.headline)
                                    .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                
            },
            trailing: HStack{
                Button(action: {
                    rootScreen = .Login
                }){
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color(UIColor(named:"Color") ?? UIColor(Color.yellow)))
                }
            })
        }
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
