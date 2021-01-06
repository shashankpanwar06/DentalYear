//
//  NoteCell.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SwipeCellKit

class NoteCell: SwipeTableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnPin: UIButton!
    @IBOutlet weak var viewBackGround: UIView!
    var pinBtnPressed:((_ aNote:Notes)->Void)?
    var editBtnPressed:((_ aNote:Notes)->Void)?

    
    @IBOutlet weak var btnEdit: UIButton!
    var aNote:Notes?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        lblTitle.text = ""
        lblDate.text = ""
        btnPin.setImage(UIImage(named: "icPin"), for: .normal)
        btnPin.isSelected  = false
    }
    
    @IBAction func onBtnEdit(_ sender: Any) {
        editBtnPressed!(self.aNote!)

        
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        lblTitle.text = ""
        lblDate.text = ""
        btnPin.setImage(UIImage(named: "icPin"), for: .normal)
        btnPin.isSelected  = false


    }

    @IBAction func onBtnPin(_ sender: Any) {
        pinBtnPressed!(self.aNote!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(note:Notes)  {
        self.layoutIfNeeded()

        self.aNote = note
        lblTitle.text = note.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,YYYY"
        lblDate.text = dateFormatter.string(from: note.date)
        btnPin.isSelected  = note.ispinned
        if note.ispinned {
            btnPin.setImage(UIImage(named: "icPinSlected"), for: .normal)
        }else
        {
            btnPin.setImage(UIImage(named: "icPin"), for: .normal)
        }
        viewBackGround.makeRoundLeftCorner()


    }
    
}
