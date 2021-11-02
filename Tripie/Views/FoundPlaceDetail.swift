//
//  FoundPlaceDetail.swift
//  Tripie
//
//  Created by Jakub Kachlík on 21.10.2021.
//
import SwiftUI

struct FoundPlaceDetail: View {
    @State var placeStruct : Places
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack(alignment:.center) {
                    Text(placeStruct.name)
                        .font(.largeTitle)
                    Spacer()
                    Button(action:{placeStruct.rename()}){
                        Image(systemName: placeStruct.isFavorite ? "star.fill" : "star").font(.title2)
                            .foregroundColor(placeStruct.isFavorite ? Color.yellow : Color.black)
                    }

                }
                .padding([.bottom, .trailing])

                HStack {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text(String(placeStruct.numberOfVisiters))
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "map.fill")
                        Text(String(placeStruct.howFar)+" km")
                    }
                    .padding([.top, .bottom, .trailing])
                }
                Text(placeStruct.descriptionOfPlace)
                    .padding([.top,.bottom], 25)
            }
            .padding(20)
        }
    }
}

struct FoundPlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoundPlaceDetail(placeStruct: testPlaces[0])
    }
}
