//
//  ContentView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI


// this view will be showing:
//the tab view for the buyer (ProductsListViw/OrdersHistoryView)
//or will have one view for the hustler (OrdersListView-> OrddeDetialView)

struct ContentView: View {
    
    @Binding var rootScreen :RootView
    @EnvironmentObject var dataSource: DataSoruce
    
    var body: some View {
        TabView {
            ProductsListView()
                .tabItem {
                    Label("Products", systemImage: "list.dash")
                }
            
            OrdersHistoryView()
                .tabItem {
                    Label("Order History", systemImage: "clock")
                }
        }
        .navigationTitle("Hustler")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
