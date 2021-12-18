//
//  TripieApp.swift
//  Tripie
//
//  Created by janoskvara on 10/26/21.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct TripieApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
