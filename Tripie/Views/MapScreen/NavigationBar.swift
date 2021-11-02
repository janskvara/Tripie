//
//  NavigationBar.swift
//  Tripie
//
//  Created by Jakub Kachlík on 16.10.2021.
//
import SwiftUI


struct NavigationBar: View {
    var body: some View {
        VStack {
            NavigationView{
                VStack {
                    VStack(alignment: .leading) {
                        MenuBarItem(menu: MenuList[0], destination: DiscoverPlaces(searchString: ""))
                        MenuBarItem(menu: MenuList[1], destination: FavoritePlaces())
                        MenuBarItem(menu: MenuList[2], destination: MyTrips())
                        MenuBarItem(menu: MenuList[3], destination: Contacs())
                        Spacer()
                    }
                }
                .navigationTitle("MYAPP")
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
