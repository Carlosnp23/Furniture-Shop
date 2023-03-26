//
//  Places.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI
import MapKit


struct Place: Identifiable {
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
