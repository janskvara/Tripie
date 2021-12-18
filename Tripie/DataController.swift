//
//  DataController.swift
//  Tripie
//
//  Created by janoskvara on 12/17/21.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Data")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
