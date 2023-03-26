//
//  MapView.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel

    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Self.Context) -> UIView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Self.Context)  {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
/*        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // Custom Pins
            
            // Excluding user Blue Circle
            
            
        }
*/
    }
    
}
