//
//  PlaceDetail.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 14.11.2021.
//

import SwiftUI

struct PlaceDetail: View {
  
    @State var detailsOfPlace : PlaceDetailModel
    @State var safariOpened: Bool = false
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(self.detailsOfPlace.name)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Label("Distance: \(String(Int(detailsOfPlace.dist))) m", systemImage: "app.connected.to.app.below.fill")
                    .foregroundColor(.gray)
                    .padding(.bottom, 3)
                Label("Famous rate: \(detailsOfPlace.rate)", systemImage: "star")
                    .foregroundColor(.gray)
                    .padding(.bottom, 3)
    
                if let imageURL = self.detailsOfPlace.imageUrl{
                        Label("Picture", systemImage: "photo")
                            .onTapGesture {
                                safariOpened.toggle()
                            }
                            .fullScreenCover(isPresented: $safariOpened){
                                SFSafariViewWrapper(url: URL(string: imageURL)!)
                            }
                            .padding(.bottom, 3)

                    }
                
                if let wikiURL = self.detailsOfPlace.wikipeida{
                        Link(destination:URL(string: wikiURL)!){
                            Label("Wikipedia", systemImage: "link")
                                .padding(.bottom, 3)}
                    }
                if let website = self.detailsOfPlace.website{
                        Link(destination:URL(string: website)!){
                            Label("Website", systemImage: "network")
                                .padding(.bottom, 3)}
                    }

                if let description = self.detailsOfPlace.placeDescription{
                        ScrollView{Text(description)}
                }
            }
        .font(.title3)
        .foregroundColor(.blue)
    }
}
