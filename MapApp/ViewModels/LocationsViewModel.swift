//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Bilol Sanatillaev on 23/08/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on the map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)

    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location details via sheet
    @Published var sheetLocation: Location? = nil  
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    // Update the Current region on map
    private func updateMapRegion(location: Location) {
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan)
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        DispatchQueue.main.async {
            self.mapLocation = location
            self.showLocationsList = false
        }
    }

    
    func nextButtonPressed() {
        // get index of current location
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find the index of current location")
            return
        }
        
        
        // set the next index
        let nextIndex =  currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next item is not exist
            // restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // get next item in locations array
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
