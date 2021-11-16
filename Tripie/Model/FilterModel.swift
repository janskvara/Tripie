//
//  FilterModel.swift
//  OnlyMapView
//
//  Created by Jakub Kachlík on 11.11.2021.
//

import Foundation
let DEFAULT_LIMIT = 5.0

enum F_Categ: String {
    case adults = "adults"
    case accomodations = "accomodations"
    case amusements = "amusements"
    case interestingPlaces = "interesting_places"
    case sport = "sport"
    case touristFacilities = "tourist_facilities"
}

struct Filter{
    var limit = DEFAULT_LIMIT
    var categories = Categories()
}

struct Categories{
    var adults = false
    var accomodations = false
    var amusements = false
    var interestingPlaces = false
    var sport = false
    var touristFacilities = false
     }
