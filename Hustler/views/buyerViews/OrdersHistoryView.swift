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
    @StateObject var fireDBHelper = FireDBHelper(store: Firestore.firestore())
    var body: some View {
        VStack{
            List {
                Section(header: Text("Pending")) {
                    ForEach(self.fireDBHelper.pendingList,id: \.id){order in
                            VStack(alignment: .leading){
                                HStack {
                                    URLImage(URL(string: order.product.pImageURI)!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(10)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(order.product.pName)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Price: $\(String(format: "%.2f", order.product.pPrice))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }//VStack
                    }
                }
                
                Section(header: Text("Completed")) {
                    ForEach(self.fireDBHelper.completedList,id: \.id){order in
                            VStack(alignment: .leading){
                                HStack {
                                    URLImage(URL(string: order.product.pImageURI)!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(10)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(order.product.pName)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Price: $\(String(format: "%.2f", order.product.pPrice))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }//VStack
                    }
                }
                
                Section(header: Text("Canceled")) {
                    ForEach(self.fireDBHelper.canceledList,id: \.id){order in
                            VStack(alignment: .leading){
                                HStack {
                                    URLImage(URL(string: order.product.pImageURI)!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(10)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(order.product.pName)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Price: $\(String(format: "%.2f", order.product.pPrice))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }//VStack
                    }
                    
                }
            }.onAppear(perform: {
                reset()
                self.fireDBHelper.getAllPendingOrder()
                self.fireDBHelper.getAllCompletedOrder()
                self.fireDBHelper.getAllCanceledOrder()
                
            })
            
        }
    }
    func reset(){
        self.fireDBHelper.pendingList = [Order]()
        self.fireDBHelper.completedList = [Order]()
        self.fireDBHelper.canceledList = [Order]()
    }
}


