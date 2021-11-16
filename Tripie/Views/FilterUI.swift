//
//  FilterUI.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 10.11.2021.
//

import SwiftUI
import MapKit

struct FilterUI: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var FilterModel : Filter
    var Markers : Api
    @Binding var MapCoordinates : MapCoordinates
    @State var searchRadius : Int
    
    var body: some View {
            VStack {
                HStack {
                    Slider(value: $FilterModel.limit, in: 1...50, step: 1)
                    Text(String(FilterModel.limit))
                }
                VStack {
                    Toggle("Adults", isOn: $FilterModel.categories.adults)
                        Toggle("Accomodations", isOn: $FilterModel.categories.accomodations)
                        Toggle("Amusements", isOn: $FilterModel.categories.amusements)
                        Toggle("Interesting places", isOn: $FilterModel.categories.interestingPlaces)
                        Toggle("Sport", isOn: $FilterModel.categories.sport)
                        Toggle("Tourist facilites", isOn: $FilterModel.categories.touristFacilities)
                    }
            }
            .navigationTitle("Filter")
            .navigationBarItems(trailing: Button(action:{
                Markers.places = []
                Markers.getData(radius: searchRadius, mapCoordinates: MapCoordinates.defaultLocation.center, filter: FilterModel)
                self.mode.wrappedValue.dismiss()
            }){
                Text("Apply")
            }
                                    .buttonStyle(.automatic))
        
    }
}

struct FilterUI_Previews: PreviewProvider {
    static var previews: some View {
        FilterUI(FilterModel: .constant(Filter()), Markers: Api(), MapCoordinates: .constant(MapCoordinates(defaultLocation: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.075539, longitude: 14.437800), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))), searchRadius: 50)
    }
}
