//
//  EntityTypes.swift
//  CoreDataCRUD
//
//  Copyright © 2016 Jongens van Techniek. All rights reserved.
//

import Foundation

/**
    Enum for holding different entity type names (Coredata Models)
*/
enum EntityTypes: String {
    case Note = "Note"
    //case Foo = "Foo"
    //case Bar = "Bar"

    static let getAll = [Note] //[Event, Foo,Bar]
}
