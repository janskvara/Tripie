//
//  Choosecountry.swift
//  Tripie
//
//  Created by Jakub Kachlík on 22.10.2021.
//
import SwiftUI
import MapKit

struct MapPlaceSelection: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.081820,
                                       longitude: 14.437695),
        latitudinalMeters: 9000000,
        longitudinalMeters: 9000000
    )

    @State var country = "Nothing"

    
    var body: some View {
        VStack {
            HStack {
                Text(country)
                Spacer()
                SearchPlacesButton(region: $region, country: $country)
                
            }.padding([.leading,.trailing], 45)
            
            ZStack {
                MapSelector(region: $region)
                AimCross()
                LocateButton(region: $region)
            }
        }
    }
}

struct Choosecountry_Previews: PreviewProvider {
    static var previews: some View {
        MapPlaceSelection()
    }
}
