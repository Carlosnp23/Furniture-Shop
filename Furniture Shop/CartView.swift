//
//  CartView.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI
private var quantityCount: Int = 1

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var quantity = quantityCount
    @State private var tax = 0.13
    @State private var totalShop = ""
    
    var body: some View {
        ScrollView {
            if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product)
                    }
                    
                    VStack {
                        
                        Text("Taxes: C$\(Double(cartManager.total * quantityCount) * tax, specifier: "%.2f")")
   
                        Spacer()
                        
                        Text("Total: C$\(totalShop)")
                            .bold()
                            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {_ in
                                self.totalShop = String(format:"%0.2f", (Double(cartManager.total * quantityCount) + Double(cartManager.total * quantityCount) * tax))
                            }
                                                
                    }
                    .padding(.top)
                    
                } else {
                    Text("Your cart is empty.")
                }
        }
        .navigationTitle(Text("Your Cart"))
        .padding(.top)
        .onDisappear {
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var quantity = quantityCount
    
    var product: Product
    
    var body: some View {
        HStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.name)
                    .bold()
                
                Text("$\(product.price * quantity)")
                
                coloredStepper(quantity: $quantity, range: 1...7, step: 1, onIncrement: { print("Incremented: \(quantity)") }, onDecrement: { print("Decremented: \(quantity)")} )
            }
                        
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                    quantityCount = 1
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productList[2])
            .environmentObject(CartManager())
    }
}

struct coloredStepper: View {
    @Binding var quantity: Int
    let range: ClosedRange<Int>
    let step: Int
    let onIncrement: (() -> Void)?
    let onDecrement: (() -> Void)?
    @State private var quantityChanged = false

    var body: some View {
        HStack {
            Button {
                decrement()
            } label: {
                Image(systemName: "minus.circle")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderless)
            
            Text("\(quantity)")
            
            Button {
                increment()
            } label: {
                Image(systemName: "plus.circle")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderless)
            
        }
        .onAppear() {
            if quantity < range.lowerBound {
                quantity = range.lowerBound
            } else if quantity > range.upperBound {
                quantity = range.upperBound
            }
        }
    }

    func decrement() {
        if quantity > range.lowerBound {
            quantity -= step
            quantityChanged = true
        }
        if quantity < range.lowerBound {
            quantity = range.lowerBound
        }
        if let onDecrement = onDecrement {
            if quantityChanged {
                onDecrement()
                quantityChanged = false
            }
        }
        quantityCount = quantity
        print("Count: \(quantityCount)")
    }

    func increment() {
        if quantity < range.upperBound {
            quantity += step
            quantityChanged = true
        }
        if quantity > range.upperBound {
            quantity = range.upperBound
        }
        if let onIncrement = onIncrement {
            if quantityChanged {
                onIncrement()
                quantityChanged = false
            }
        }
        quantityCount = quantity
        print("Count: \(quantityCount)")
    }
}
