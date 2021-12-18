//
//  Trip.swift
//  Tripie
//
//  Created by janoskvara on 12/17/21.
//
import SwiftUI

struct TripView: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var places : FetchedResults<Place>
    
    var name : String
    
    init(nameOfTrip: String){
        name = nameOfTrip
    }
    
    var body: some View{
        NavigationView{
            List{
                ForEach(places.filter(){place in return place.trip == self.name}, id: \.self){ place in
                    NavigationLink(destination: PlaceDetail(detailsOfPlace: PlaceDetailModel(name: place.name!, dist: place.dist, rate: Int(place.rate), imageUrl: place.imageUrl, wikipeida: place.wikipeida, website: place.website, placeDescription: place.placeDescription))){
                        Text(place.name ?? "UnknownTrip")
                    }
                }.onDelete(perform: deleteFavoritePlace)
            }
        }.navigationTitle("\(self.name) trip")
    }
    
    private func deleteFavoritePlace(at  offsets: IndexSet){
        for index in offsets{
            let place = places[index]
            moc.delete(place)
        }
        try? moc.save()
    }
}
