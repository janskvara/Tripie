//
//  LocateButton.swift
//  Tripie
//
//  Created by Jakub Kachlík on 26.10.2021.
//
import SwiftUI
import MapKit

struct LocateButton: View {
    @Binding var region : MKCoordinateRegion
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button(action:{
                    region.center = LocateMe().getMyLocation()
                }){
                Image(systemName: "mappin.and.ellipse")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(Color.black, width: 1)
                }
                    
            }
        }.padding(50)    }
}

struct LocateButton_Previews: PreviewProvider {
    static var previews: some View {
        LocateButton(region: .constant(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.081820,
                                           longitude: 14.437695),
            latitudinalMeters: 9000000,
            longitudinalMeters: 9000000
        )))
    }
}
