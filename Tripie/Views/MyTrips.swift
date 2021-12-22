//
//  MyTrips.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 06.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct MyTrips: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var trips : FetchedResults<Trip>
    @FetchRequest(sortDescriptors: []) var places : FetchedResults<Place>
    
    @State private var isPresented: Bool = false
    @State private var text: String = ""
    
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    ForEach(trips, id: \.self){ trip in
                        NavigationLink(destination: TripView(nameOfTrip: trip.name ?? "UnknownTrip")){
                            Text(trip.name ?? "UnknownTrip")
                        }
                        .swipeActions{
                            Button(action:{
                                deleteTrip(trip: trip)
                            }){
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
                .navigationBarItems(trailing:
                                        Button(action:{self.isPresented = true}){
                                                            Text("+").font(.largeTitle).bold()})
                    .navigationTitle(Text("Trips"))
            }
            AddTripAlert(title: "Add Trip", isShown: $isPresented, text: $text, onDone: { nameOfTrip in
                let trip = Trip(context: moc)
                trip.id = UUID()
                trip.name = nameOfTrip
                try? moc.save()
            })
        }
    }
    
    private func deleteTrip(trip:Trip){
        
        let tripToDelete = trips.first{$0.id == trip.id}
        let tripsPlaces = places.filter{$0.trip == trip.name}
        for place in tripsPlaces{
            moc.delete(place)
        }
        moc.delete(tripToDelete!)
        try? moc.save()
    }
}

@available(iOS 15.0, *)
struct MyTrips_Previews: PreviewProvider {
    static var previews: some View {
        MyTrips()
    }
}
