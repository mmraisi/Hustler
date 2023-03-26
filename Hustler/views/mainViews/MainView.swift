//
//  MainView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

// this view will be used to decide wether the user is buyer or hustler
// the view will consist of two buttons (one for buer and the other is hustler)
// based on the user selection, the user will be redirected to the Login view

struct MainView: View {
    var dataSource : DataSoruce = DataSoruce()
    private let fireAuthHelper = FireAuthHelper()
    
    
    @State private var root : RootView = .Login
    
    var body: some View {
        
        NavigationView{
            switch root{
            case .Login:
                SignInView(rootScreen : $root).environmentObject(dataSource).environmentObject(fireAuthHelper)
            case .BUYER_HOME:
                ContentView(rootScreen : $root).environmentObject(dataSource)
            case .HUSTLER_HOME:
                OrdersListView().environmentObject(dataSource)
            }
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        
    }//body
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
