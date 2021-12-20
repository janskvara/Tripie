//
//  ContentView.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 06.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        TabView{
            MapScreen()
                .tabItem{
                Label("Discover", systemImage: "magnifyingglass")
            }
            MyTrips()
                .tabItem{
                    Label("My trips", systemImage: "map")
                }
            FavoritePlaces()
                .tabItem{
                    Label("Favorite", systemImage: "heart")
                }
            }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
