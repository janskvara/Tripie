//
//  Places.swift
//  Tripie
//
//  Created by Jakub Kachlík on 16.10.2021.
//
import Foundation
import SwiftUI

struct Places:Hashable, Decodable{
    var name:String
    var howFar:Float
    var isFavorite:Bool
    var numberOfVisiters:Int
    var descriptionOfPlace: String
    mutating func invertFavorite(){
        isFavorite = !isFavorite
    }
    mutating func rename(){
        name = "Change"
    }
}



var testPlaces = [
    Places(name: "First place to visit", howFar: 250, isFavorite: true, numberOfVisiters: 200000, descriptionOfPlace: "Very Insteresting place to have a fun with everybody my friend."),
    Places(name: "Second", howFar: 10, isFavorite: false, numberOfVisiters: 3200000, descriptionOfPlace: "Very demanding to kill every fish you find. Insteresting place to have a fun with everybody my friend."),
    Places(name: "Third", howFar: 1000, isFavorite: false, numberOfVisiters: 600000, descriptionOfPlace: "Insteresting place to have a fun with everybody my friend."),
    Places(name: "Third", howFar: 1000, isFavorite: false, numberOfVisiters: 12300000, descriptionOfPlace: "Very Insteresting place to have a fun with everybody my friend."),
    Places(name: "Third", howFar: 1000, isFavorite: false, numberOfVisiters: 20000, descriptionOfPlace: "place to have a fun with everybody my friend."),
    Places(name: "Third", howFar: 1000, isFavorite: false, numberOfVisiters: 2000, descriptionOfPlace: "Squid Insteresting place to have a fun with everybody my friend."),
    Places(name: "Third", howFar: 1000, isFavorite: false, numberOfVisiters: 55800000, descriptionOfPlace: "Rododendron Insteresting place to have a fun with everybody my friend.")

]
