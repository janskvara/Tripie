//
//  CurrentLocation.swift
//  Tripie
//
//  Created by Jakub Kachlík on 26.10.2021.
//
import Foundation
import CoreLocation

class LocateMe{
    func getMyLocation ()->CLLocationCoordinate2D{
        return CLLocation().coordinate
    }
}
