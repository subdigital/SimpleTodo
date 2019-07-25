//
//  TodoItem+CoreDataProperties.swift
//  TodoApp
//
//  Created by Ben Scheirman on 7/25/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var text: String
    @NSManaged public var isCompleted: Bool
    @NSManaged public var sortOrder: Int32

}
