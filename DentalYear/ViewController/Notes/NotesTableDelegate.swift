//
//  NotesTableDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit
extension NotesViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell:NoteCell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        aCell.set(note: dataArray[indexPath.row])
        aCell.pinBtnPressed = {
            note in
            self.markNotePinned(aNote: note)
        }
        aCell.editBtnPressed = {
            note in
            self.editNote(aNote: note)
        }
        aCell.delegate = self
        
        return aCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tappedRow(index: indexPath.row)
    }
}
extension NotesViewController:SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .default, title: "") { action, indexPath in
            // handle action by updating model with deletion
            self.markDeleted(index: indexPath.row)
        }
        deleteAction.backgroundColor = UIColor.clear

        // customize the action appearance
        deleteAction.image = UIImage(named: "icDelete")

        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        options.transitionStyle = .reveal
        options.backgroundColor  = UIColor.clear
        options.buttonPadding = 0

        return options
    }
    
}
