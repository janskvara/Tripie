//
//  MenuBars.swift
//  Tripie
//
//  Created by Jakub Kachlík on 17.10.2021.
//
import Foundation
import SwiftUI

struct Menu{
    var name:String
    var description:String
    var color:Color
    var symbol:Image
}

var MenuList = [
    Menu(
        name: "Discover",
        description: "Explore new interesting places in place you want to visit",
        color: Color("Menu_Find"),
        symbol: Image(systemName: "magnifyingglass.circle.fill")
    ),
    Menu(
        name: "Favorite",
        description: "Take a look at the list of places you like",
        color: Color("Menu_Favorite"),
        symbol: Image(systemName: "heart.circle.fill")
    ),
    Menu(
        name: "My trips",
        description: "Browse through trips you have planned",
        color: Color("Menu_MyTrips"),
        symbol: Image(systemName: "globe.europe.africa.fill")
    ),
    Menu(
        name: "Contacts",
        description: "Explore new interesting places in place you want to visit",
        color: Color("Menu_Contacts"),
        symbol: Image(systemName: "envelope.circle.fill")
    )
]
