//
//  Product.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "Bar", image: "Bar", price: 120),
                   Product(name: "Sofa", image: "Sofa", price: 250),
                   Product(name: "Rack", image: "Rack", price: 350)]
