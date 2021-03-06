//
//  MapScreen.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 06.11.2021.
//

import SwiftUI
import MapKit


@available(iOS 15.0, *)
struct MapScreen: View {
    @State var FilterModel = FilterViewModel().FilterModel
    @State var MapCoordinates = MapViewModel().MapModel
    @ObservedObject var GottenApiResults = Api()
    var locator = CurrentLocation()

    @State private var defaultOffset : CGFloat = 2.5
    @State var RatingSlider = 50.0
    @State var ShownPlace : Features?
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Map(coordinateRegion: $MapCoordinates.defaultLocation, showsUserLocation: true, annotationItems: GottenApiResults.places, annotationContent: { marker in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(marker.geometry.coordinates[0]), longitude: CLLocationDegrees(marker.geometry.coordinates[1]))){
                            Button(action:{
                                self.ShownPlace = marker
                                self.GottenApiResults.getData(xid:marker.properties.xid)
                                withAnimation{
                                    MapCoordinates.defaultLocation.center = CLLocationCoordinate2D(latitude: CLLocationDegrees(marker.geometry.coordinates[0]), longitude: CLLocationDegrees(marker.geometry.coordinates[1]))
                                }
                            }){
                            Image(systemName: "mappin.circle")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                        }
                    })
                        .ignoresSafeArea()
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(lineWidth: 5)
                        .cornerRadius(.infinity)
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width*(CGFloat(RatingSlider)/100), height: geometry.size.width*(CGFloat(RatingSlider)/100))

                    VStack(alignment:.trailing) {
                        HStack(alignment:.top) {
                            NavigationLink(destination: FilterUI(FilterModel: $FilterModel, Markers: GottenApiResults, MapCoordinates: $MapCoordinates, searchRadius: Int(MapCoordinates.defaultLocation.span.longitudeDelta * 111139 / 3 * (RatingSlider/100))))
                            {
                                Label("Filter", systemImage: "slider.vertical.3")
                            }
                                .font(.title3)
                                .padding(10)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .cornerRadius(10)
                            Spacer()
                            VStack(alignment:.trailing) {
                                Button(action: {
                                    let searchRadius = Int(MapCoordinates.defaultLocation.span.longitudeDelta * 111139 / 3 * (RatingSlider/100))
                                     GottenApiResults.getData(radius: searchRadius, mapCoordinates: MapCoordinates.defaultLocation.center, filter: FilterModel)
                                })
                                {
                                    Text("Search")
                                        .font(.title3)
                                        .padding(10)
                                        .foregroundColor(.blue)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                
                                Button(action:{
                                    locator.checkIfLocationIsEnabled()
                                    self.MapCoordinates.defaultLocation = locator.region2
                                }){
                                    Image(systemName: "location")
                                        .font(.title3)
                                        .padding(10)
                                        .foregroundColor(.blue)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                Spacer()
                                
                                    Slider(value: $RatingSlider, in: 1...100, step:1)
                                        .foregroundColor(.blue)
                                        .rotationEffect(Angle(degrees: 90), anchor: .topTrailing)
                                        .frame(width: geometry.size.height/3)
                                
                                Spacer()
                                
                            }

                        }
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        
                        VStack(alignment:.leading) {
                            HStack {
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .font(.largeTitle)
                                    .padding([.top, .leading, .trailing], 10)
                                Spacer()
                            }
                            VStack (alignment:.leading) {
                                HStack {
                                    Text((ShownPlace != nil) ? ShownPlace!.properties.name : "No place selected")
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                        .font(.title)
                                        .lineLimit(1)
                                    Spacer()
                                    NavigationLink(destination:LazyView(PlaceDetailsSettingsView(place: self.ShownPlace!, apiDetail: self.GottenApiResults ))){
                                        Text("Find more")
                                            .font(.title3)
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                    }
                                    .disabled(self.ShownPlace == nil)
                                }

                                Text("Place rating (1-7): \((ShownPlace != nil) ? String(ShownPlace!.properties.rate) : "no data")")
                                    .padding(5)
                                Text("Categories: \((ShownPlace != nil) ? (ShownPlace!.properties.kinds)?.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: ",", with: ", ") ?? "Empty" : "no assigned categories")")
                                    .lineLimit(3)
                                    .padding(5)
                                Spacer()
                            }
                            Spacer()
                        }

                        .frame(width: geometry.size.width, height: geometry.size.height/2)
                        .background(Color.white.opacity(0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth:2)
                        )
                        .offset(y: geometry.size.height/defaultOffset)
                        .gesture(DragGesture()

                                    .onEnded({ value in
                            withAnimation{
                                defaultOffset = defaultOffset == 2.5 ? 4.5 : 2.5
                            }
                        }))
                        .onTapGesture(perform: {
                            withAnimation{
                                defaultOffset = defaultOffset == 2.5 ? 4.5 : 2.5
                            }
                        })
                    }
                }
            .navigationBarHidden(true)
            }
        }
    }
}

@available(iOS 15.0, *)
struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
