//
//  PlaceDetailsSettingsView.swift
//  Tripie
//
//  Created by janoskvara on 12/17/21.
//

import SwiftUI

struct PlaceDetailsSettingsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var trips : FetchedResults<Trip>
    @FetchRequest(sortDescriptors: []) var places : FetchedResults<Place>
    
    var apiDetail: Api
    var place : Features
    @State private var isPresented: Bool = false
    @State private var text: String = ""
    @State private var selectedItem = "undefined"
    init(place:Features, apiDetail: Api){
        self.place = place
        self.apiDetail = apiDetail
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                PlaceDetail(detailsOfPlace: PlaceDetailModel(name: place.properties.name, dist: place.properties.dist, rate: place.properties.rate, imageUrl: self.apiDetail.detail?.image, wikipeida: self.apiDetail.detail?.wikipedia, website: self.apiDetail.detail?.url, placeDescription: self.apiDetail.detail?.wikipedia_extracts?.text))
                    .padding(.bottom, 20)
                Spacer()
                HStack{
                    Button(action: {addPlacesToFavorite()}){
                        Label("Favorite", systemImage: "heart")
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    Picker("Add to trip", selection: $selectedItem, content: {
                        Text("Add new trip").tag("Add new trip")
                        ForEach(trips, id: \.self){trip in
                            Text(trip.name ?? "Unknown name").tag(trip.name ?? "Unknown name")
                        }
                    }).pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedItem){ tag in
                        if(tag == "undefined"){
                            return
                        }
                        if(tag == "Add new trip"){
                            isPresented = true
                            selectedItem = "undefined"
                            return
                        }
                        addPlaceToTrip(trip: tag)
                        return
                    }
                }
            }.padding()
            AddTripAlert(title: "Add Trip", isShown: $isPresented, text: $text, onDone: { nameOfTrip in
                let trip = Trip(context: moc)
                trip.id = UUID()
                trip.name = nameOfTrip
                try? moc.save()
            })
        }
    }
    
    func addPlacesToFavorite(){
        addPlaces(trip: "", favorite: true)
    }
    
    func addPlaceToTrip(trip: String){
        addPlaces(trip: trip, favorite: false)
        
    }
    
    func addPlaces(trip:String, favorite:Bool){
        let newPlace = Place(context: moc)
        newPlace.name = place.properties.name
        newPlace.dist = place.properties.dist
        newPlace.rate = Int32(place.properties.rate)
        newPlace.imageUrl = apiDetail.detail?.image
        newPlace.website = apiDetail.detail?.url
        newPlace.wikipeida = apiDetail.detail?.wikipedia
        newPlace.placeDescription = apiDetail.detail?.wikipedia_extracts?.text ?? "No description"
        newPlace.trip = trip
        newPlace.favorite = favorite
        try? moc.save()
    }
}
