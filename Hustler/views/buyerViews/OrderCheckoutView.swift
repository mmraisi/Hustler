//
//  OrderCheckoutView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 21/03/2023.
//

import SwiftUI
import URLImage
import Firebase

struct OrderCheckoutView: View {
    @State private var cName: String = ""
    @State private var cAddress: String = ""
    @State private var showingAlert = false
    @EnvironmentObject var locationHelper:LocationHelper
    @Environment(\.dismiss) private var dismiss
    let product:Product
    var body: some View {
        VStack{
            Text("Confirm Order").font(.headline).frame(alignment: .center)
            HStack(spacing:10){
                VStack{
                    URLImage(URL(string: product.pImageURI)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                VStack{
                    Text("\(product.pName)").font(.title)
                    Text("$\(product.pPrice,specifier: "%.2f")").font(.caption)
                    Spacer()
                }.padding(.horizontal)
            }
            .frame(height: 100)
            Spacer()
            Text("Customer Details").font(.headline).frame(alignment: .center)
            Form {
                Section(header: Text("Customer information")) {
                    TextField("Name", text: $cName)
                        .keyboardType(.numberPad)
                    TextField("Address", text: $cAddress)
                        .keyboardType(.namePhonePad)
                }
            }
            
            
            Button(action: {
                purchase()
            }, label: {
                Text("Buy")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .padding(.bottom, 10)
            
        }.frame(height: 500)
            .alert(isPresented: $showingAlert){
                Alert(
                    title: Text("Error"),
                    message: Text("Name or Address must not be empty"),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    func purchase(){
        if(cName.isEmpty || cAddress.isEmpty){
            showingAlert = true
            return
        }else{
            let lat:Double = locationHelper.currentLocation?.coordinate.latitude ?? 0.0
            let long:Double = locationHelper.currentLocation?.coordinate.longitude ?? 0.0
            let customer = Customer(cName: cName, cEmail: (Auth.auth().currentUser?.email)!, cAddress: cAddress, cLong: long, cLat: lat)
            let order = Order(product: product, customer: customer, storeName: "North Face", isAccepted: true)
            dismiss()
        }
    }
}

