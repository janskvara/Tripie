//
//  ChooseCountryButton.swift
//  Tripie
//
//  Created by Jakub Kachlík on 24.10.2021.
//
import SwiftUI
import MapKit

struct SearchPlacesButton: View {
    var defaultRadius = 5000
    let defaultAPIKey = "5ae2e3f221c38a28845f05b6d8852d7cc0e894fa7e45aa19666b1410"
    var ApiClass = Api()
    
    @Binding var region : MKCoordinateRegion
    @Binding var country : String
    var destination = AimCross()
    var body: some View {
        VStack {
            Button(action:{
                country = "Changed"
                Api().loadRadius(radius: defaultRadius, lon: region.center.longitude, lat: region.center.latitude, limit: 1, apikey: defaultAPIKey, completion: {(succes) -> Void in
                    let value = try? succes.get()
                    country = value?.features[0].properties.name ?? "Loading ..."
                })
            }){
                Text("Search")
                    .font(.title2)
            }
        }
        
    }
}

struct ChooseCountryButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesButton(region: .constant(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.081820,
                                           longitude: 14.437695),
            latitudinalMeters: 9000000,
            longitudinalMeters: 9000000
        )), country: .constant("Text"))
    }
}
