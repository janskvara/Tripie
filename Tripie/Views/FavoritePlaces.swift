//
//  FavoritePlaces.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 06.11.2021.
//

import SwiftUI

struct FavoritePlaces: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var places : FetchedResults<Place>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(places.filter(){place in return place.favorite}, id: \.self){ place in
                    NavigationLink(destination: PlaceDetail(detailsOfPlace: PlaceDetailModel(name: place.name!, dist: place.dist, rate: Int(place.rate), imageUrl: place.imageUrl, wikipeida: place.wikipeida, website: place.website, placeDescription: place.placeDescription))){
                        Text(place.name ?? "UnknownTrip")
                    }
                }.onDelete(perform: deleteFavoritePlace)
            }.navigationTitle("Favorite places")
        }
    }
    
    private func deleteFavoritePlace(at  offsets: IndexSet){
        for index in offsets{
            let place = places[index]
            moc.delete(place)
        }
        try? moc.save()
    }
}
