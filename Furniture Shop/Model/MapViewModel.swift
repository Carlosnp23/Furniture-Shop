//
//  MapViewModel.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI
import MapKit
import CoreLocation

    // All Map Data goes here.
class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    
    // Region
    @Published var region : MKCoordinateRegion!
    // Based on Location it will set up.
    
    // Alert
    @Published var permissionDenied = false
    
    // Map Type
    @Published var mapType: MKMapType = .standard
    
    // Update Map Type
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus Location
    func focusLocation() {
        
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search
    @Published var search = ""
    
    // Search Places
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        // Fetch
        MKLocalSearch(request: request).start { (response, _) in
            
            guard let result = response else {return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Searched Place
    @Published var places: [Place] = []
    
    // Pick Search result
/*    func selectPlace(place: Place) {
        
        search = ""
        
        guard let coordinate = place.placemark.location?         else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
        
        
        // Removing all Old ones
        mapView.removeAnnotation(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
    }
*/
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking Permissions.
        switch manager.authorizationStatus {
        case .denied:
            // Alert
            permissionDenied.toggle()
            
        case .notDetermined:
            // Requesting
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse:
            // If Permission given
            manager.requestLocation()
        
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // Error
        print(error.localizedDescription)
    }
    
    // Geting user Region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        // Updating Map
        self.mapView.setRegion(self.region, animated: true)
        
        // Smmoth Animation
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
}
