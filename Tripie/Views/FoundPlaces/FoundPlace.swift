//
//  FoundPlace.swift
//  Tripie
//
//  Created by Jakub Kachlík on 15.10.2021.
//
import SwiftUI

struct FoundPlace: View {
    @State var place : Places
    @State var apiResponse : Features?
    var body: some View {
            
            NavigationLink(destination: FoundPlaceDetail(placeStruct: place)){
        HStack {
            Image("Sankt_Jørgens_Gade")
                .resizable()
                .frame(width: 75, height: 75)
                .cornerRadius(20)
                .padding([.top, .leading, .bottom], 5)
            
            VStack {
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.title3)
                    Text(apiResponse?.properties.name ?? "whoknows")
                    Text(String(place.howFar) + " km")
                        .font(.caption2)
                }
            }
            .foregroundColor(Color.black)

            Spacer()
            /*ZStack {
                Button(action:{place.invertFavorite()}){
                    Image(systemName: place.isFavorite ? "star.fill" : "star")
                        .foregroundColor(place.isFavorite ? Color.yellow : Color.gray)
                        .padding(.trailing)
                        .font(.subheadline)
                }
            }*/

        }
        .background(Color("Search_Background"))
        .cornerRadius(10)
            }
        
    }
}

struct FoundPlace_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FoundPlace(place: testPlaces[1])
        }
    }
}
