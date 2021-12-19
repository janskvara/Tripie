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
    @State var alert = false
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
                Spacer()
                HStack{
                    if isPlaceAleradyInFavoritePlaces() {
                        Button(action: {removeFromFavorite()}){
                            Label("Unfavorite", systemImage: "heart.fill")
                                .foregroundColor(.red)
                                .font(.body)
                        }
                    }
                    else{
                        Button(action: {addPlacesToFavorite()}){
                            Label("Favorite", systemImage: "heart")
                                .foregroundColor(.red)
                                .font(.body)
                        }
                    }
                    
                    Spacer()
                    Picker("Add to trip", selection: $selectedItem, content: {
                        Text("Add new trip").tag("Add new trip")
                        ForEach(trips){trip in
                            Text(trip.name ?? "Unknown name")
                                .tag(trip.name ?? "Unknown name")
                        }
                    }).pickerStyle(MenuPickerStyle())
                        .alert(isPresented: $alert){
                            Alert(title: Text("Already added"), message: Text("This place is already added in selected trip"))
                        }

                    .onChange(of: selectedItem){ tag in
                        if(tag == "undefined"){
                            return
                        }
                        if(tag == "Add new trip"){
                            isPresented = true
                            selectedItem = "undefined"
                            return
                        }
                        let tmp = places.first{($0.xid == place.properties.xid && $0.trip == selectedItem)}
                        if (tmp != nil){
                            alert.toggle()
                            return
                        }
                        else{
                            addPlaceToTrip(trip: tag)
                            return
                        }
                        
                    }
                }.padding()
            }
            AddTripAlert(title: "Add Trip", isShown: $isPresented, text: $text, onDone: { nameOfTrip in
                if(trips.filter({trip in return trip.name == nameOfTrip}).count != 0){
                    return
                }
                let trip = Trip(context: moc)
                trip.id = UUID()
                trip.name = nameOfTrip
                try? moc.save()
            })
        }
    }
    
    private func isPlaceAleradyInFavoritePlaces() -> Bool{
        return places.filter({_place in _place.xid == place.properties.xid && _place.favorite}).count != 0
    }

    private func addPlacesToFavorite(){
        addPlaces(trip: "", favorite: true)
    }
    
    private func addPlaceToTrip(trip: String){
        addPlaces(trip: trip, favorite: false)
        
    }
    
    private func removeFromFavorite(){
        let elementToDelete = places.first{$0.xid == place.properties.xid}
        moc.delete(elementToDelete!)
        
        try? moc.save()
    }
    
    private func addPlaces(trip:String, favorite:Bool){
        let newPlace = Place(context: moc)
        newPlace.xid = place.properties.xid
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
