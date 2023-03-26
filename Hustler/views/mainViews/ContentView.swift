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
                    }
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
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
