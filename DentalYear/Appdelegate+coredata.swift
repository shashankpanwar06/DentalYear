//
//  Appdelegate+coredata.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import CoreData
extension AppDelegate
{
    
     func enableDebugMode(_ shouldLog: Bool) {
        if shouldLog {
            //Debug - location of sqlite db file
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print("Debug - Make sure to have a SQLite database viewer installed on MacOS, for example: https://sqlitebrowser.org")
            print("Debug - location of SQLite database file:\n\n\(paths[0])\n")
            print("Debug - Select and copy the above path of the SQLite databasefile, go to MacOS Finder, click:\n\nSHIFT + CMD + G\n\nand paste path and click: OK and open the (SingleViewCoreData.sql) SQlite file with, for example: SQLite browser\n")
        }
    }

}


