//
//  MyTrips.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 06.11.2021.
//

import SwiftUI

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
                    }.onDelete(perform: self.deleteTrip)
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
    
    private func deleteTrip(at  offsets: IndexSet){
        for index in offsets{
            let trip = trips[index]
            let tripsPlaces = places.filter({place in return place.trip == trip.name})
            for place in tripsPlaces{
                moc.delete(place)
            }
            moc.delete(trip)
        }
        try? moc.save()
    }
}

struct MyTrips_Previews: PreviewProvider {
    static var previews: some View {
        MyTrips()
    }
}
