//
//  Map.swift
//  Furniture Shop
//
//  Created by Carlos Norambuena on 2023-03-26.
//

import SwiftUI
import CoreLocation

struct Map: View {
    @StateObject var mapData = MapViewModel()
    
    // Location MAnager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            // MapView
            MapView()
            // Using it as enviroment object so that it can be used ints subViews.
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                VStack(spacing: 0) {
/*                    HStack {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $mapData.search)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .padding(.top)
         
                    // Displaying results
                   if !mapData.places.isEmpty && mapData.search != "" {
                        
                        ScrollView {
                            
                            VStack(spacing: 15) {
                                
                                ForEach(mapData.places) { place in
                                    
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            
                                            mapData.selectPlace(place: place)
                                            
                                        }
                                    
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                        
                    } */
                    
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "location.circle.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "square.stack.3d.up" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onAppear(perform: {
            
            // Setting Delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        
        // Permission Denied Alert
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message:
                    Text("Please Enable Permission in App Settings"),
                  dismissButton: .default(Text("Goto Settings"),
                  action: {
                // Redireting user to Settings
                UIApplication
                    .shared
                    .open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.search, perform: { value in
            
            // Searching Places
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                if value == mapData.search {
                    
                    // Search
                    self.mapData.searchQuery()
                }
            }
        })
        
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
