//
//  Trip.swift
//  Tripie
//
//  Created by janoskvara on 12/17/21.
//
import SwiftUI

@available(iOS 15.0, *)
struct TripView: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var places : FetchedResults<Place>
    
    var name : String
    
    init(nameOfTrip: String){
        name = nameOfTrip
    }
    
    var body: some View{
            List{
                ForEach(places.filter{$0.trip == self.name}, id: \.self){ place in
                    NavigationLink(destination: PlaceDetail(detailsOfPlace: PlaceDetailModel(name: place.name!, dist: place.dist, rate: Int(place.rate), imageUrl: place.imageUrl, wikipeida: place.wikipeida, website: place.website, placeDescription: place.placeDescription))){
                        Text(place.name ?? "UnknownTrip")
                    }
                    .swipeActions{
                        Button(action:{
                            deleteFavoritePlace(place: place)
                        }){
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }//.onDelete(perform: deleteFavoritePlace)
            }
        .navigationTitle("\(self.name) trip")
    }
    
    private func deleteFavoritePlace(place: Place){
        let placeToDelete = places.first{$0.trip == self.name && $0.xid == place.xid}
        moc.delete(placeToDelete!)
        try? moc.save()
    }
}
