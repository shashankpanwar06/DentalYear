//
//  Event.swift
//  CoreDataCRUD
//
//  Copyright © 2016 Jongens van Techniek. All rights reserved.
//

import Foundation
import CoreData

/**
    Enum for Event Entity member fields
*/
enum NoteAttributes: String {
    case
    title      = "title",
    date       = "date",
    details       = "details",
    isdeleted    = "isdeleted",
    ispinned  = "ispinned",
    type      = "type"

    static let getAll = [
        title,
        date,
        details,
        isdeleted,
        ispinned
    ]
}

@objc(Note)

/**
    The Core Data Model: Event
*/
class Notes: NSManagedObject {

    @NSManaged var date: Date
    @NSManaged var title: String
    @NSManaged var details: String
    @NSManaged var isdeleted: Bool
    @NSManaged var ispinned: Bool
    @NSManaged var type: NSNumber
}
