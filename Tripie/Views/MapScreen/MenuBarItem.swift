//
//  MenuBarItem.swift
//  Tripie
//
//  Created by Jakub Kachlík on 17.10.2021.
//
import SwiftUI

struct MenuBarItem<Target:View>: View {
    let menu : Menu
    let destination : Target
    var body: some View {
        NavigationLink(destination: destination){
        HStack {
            VStack(alignment:.leading) {
                Text(menu.name)
                    .font(.largeTitle)
                Text(menu.description)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            menu.symbol
                .font(.largeTitle)
                .foregroundColor(Color("Search_Text"))
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(menu.color)
        .foregroundColor(Color.black)
}
    .cornerRadius(10)
    .padding(10)
    }
}


struct MenuBarItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarItem(menu:MenuList[0], destination: DiscoverPlaces(searchString: ""))
    }
}
