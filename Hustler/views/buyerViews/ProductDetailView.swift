//
//  ProductDetailView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import URLImage

struct ProductDetailView: View {
    let product:Product
    @State private var showCartSheet = false
    @EnvironmentObject var dataSource: DataSoruce
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var body: some View {
        VStack{
            HStack(spacing:10){
                VStack{
                    URLImage(URL(string: product.pImageURI)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                VStack{
                    Text("\(product.pName)").font(.title)
                    Text("\(product.pDesc)").font(.caption)
                    Text("$\(product.pPrice,specifier: "%.2f")").font(.caption)
                    Spacer()
                }.padding(.horizontal)
            }
            .frame(height: 300)
            
            
            Button(action: {
                showCartSheet.toggle()
            }, label: {
                Text("Confirm Order")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .padding(.bottom, 10)
            .sheet(isPresented: $showCartSheet){
                OrderCheckoutView(product: product).environmentObject(fireDBHelper)
            }
        }.frame(height: 500)
    }
    
    
}

