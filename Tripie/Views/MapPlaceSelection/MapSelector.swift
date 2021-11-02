//
//  SelectorMap.swift
//  Tripie
//
//  Created by Jakub Kachlík on 24.10.2021.
//
import SwiftUI
import MapKit

struct MapSelector: View {
    //@Binding var region: MKCoordinateRegion
    @Binding public var region : MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: .random(), userTrackingMode: .constant(.none))
            .cornerRadius(30)
            .padding()
        
    }
}

struct SelectorMap_Previews: PreviewProvider {

    static var previews: some View {
        
        MapSelector(region: .constant(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020),
                latitudinalMeters: 9000000,
                longitudinalMeters: 9000000
        )))
    }
}
