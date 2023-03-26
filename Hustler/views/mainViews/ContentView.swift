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
    
    @Binding var rootScreen :RootView
    @EnvironmentObject var dataSource: DataSoruce

    
    var body: some View {
        VStack{
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
            .navigationBarItems(leading: HStack {
                Image(systemName: "person.circle.fill")
                Text((Auth.auth().currentUser?.email)!)
                                    .font(.headline)
                
            },trailing: HStack{
//                Button(action: {
//
//                }){
//                    Image(systemName: "cart")
//                        .foregroundColor(Color.black)
//                }
                
                Button(action: {
                    
                }){
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color.black)
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
