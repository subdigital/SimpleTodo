//
//  PersistenceManager.swift
//  TodoApp
//
//  Created by Ben Scheirman on 7/25/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    static var shared = PersistenceManager()

    private let persistentContainer: NSPersistentContainer

    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "Todos")
    }

    func initializeModel(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores { (storeDesc, error) in
            if error != nil {
                print("Error loading persistent stores: \(error!)")
            } else {
                print("Loaded store: \(storeDesc)")
                completion()
            }
        }
    }
}
