//
//  DataSource.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import Foundation

enum UserType : String, CaseIterable{
    case BUYER, HUSTLER
}

class DataSoruce: ObservableObject {
    @Published var store : Store = loadStore()
    @Published var ordersHistoryList : [Order] = loadOrderHistoryList()
    @Published var currentUserType : UserType = UserType.BUYER
    
    static private func loadStore()-> Store{
        let newStore = Store()
        newStore.fillProducts()
        return newStore
    }
    
    static private func loadOrderHistoryList() -> [Order]{
        // this func will check if there's any order history in the fireStore for the logged in user and return it back
        return [Order]()
    }
}
