//
//  TodoItem.swift
//  TodoApp
//
//  Created by Ben Scheirman on 7/25/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import Foundation
import CoreData

class TodoItem : NSManagedObject {
    var text: String = ""
    var sortOrder: Int32?
    var isCompleted: Bool = false

    init(context: NSManagedObjectContext, text: String) {
        let entity = NSEntityDescription.entity(forEntityName: "TodoItem", in: context)!
        super.init(entity: entity, insertInto: context)
        self.text = text
    }
}
