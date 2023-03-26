//
//  ContentView.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
        var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(productList, id: \.id) { product in
                            ProductCard(product: product)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding()
                }
                .navigationTitle(Text("Furniture Shop"))
                .toolbar {
                    NavigationLink {
                        CartView()
                            .environmentObject(cartManager)
                    } label: {
                        CartButton(numberOfProducts: cartManager.products.count)
                    }
                    NavigationLink {
                        Map()
                    } label: {
                        MapButton()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CartButton: View {
    var numberOfProducts: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 5)

            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .cornerRadius(50)
            }
        }
    }
}

struct MapButton: View {
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "map.circle.fill")
                .padding(.top, 5)

        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numberOfProducts: 1)
    }
}
