//
//  DiscoverPlaces.swift
//  Tripie
//
//  Created by Jakub Kachlík on 15.10.2021.
//
import SwiftUI

protocol Screen:View{}

struct DiscoverPlaces: Screen{
    @State var searchString : String = ""
    @State var Places = testPlaces
    
    var body: some View {
        HStack(alignment:.top) {
                VStack(alignment: .leading) {
                    VStack{
                        NavigationLink(destination: MapPlaceSelection()){
                            Text("Find on map")
                            Image(systemName: "map")
                        }.scaleEffect(1.5)
                        TextField("Search bar", text: $searchString)
                            .padding(10)
                            .padding([.leading])
                            .background(Color("Search_Background"))
                            .cornerRadius(10)
                            .padding()
                            ForEach(searchString == "" ? Places : Places.filter{
                                $0.name.contains(searchString)}, id:\.self){ place in
                                    FoundPlace(place: place)
                                }
                            Spacer()
                    }._scrollable()
            }
            
        }
    }
}

struct DiscoverPlaces_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DiscoverPlaces()
        }
    }
}
