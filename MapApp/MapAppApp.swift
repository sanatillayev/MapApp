//
//  MapAppApp.swift
//  MapApp
//
//  Created by Bilol Sanatillaev on 23/08/23.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm: LocationsViewModel = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
