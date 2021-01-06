//
//  WantHereCell.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class WantHereCell: UITableViewCell {
    var wantHereBtnPressed:(()->Void)?

    @IBOutlet weak var wantHereButton: UIButton!
    @IBOutlet weak var toView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onBtnWantHere(_ sender: Any) {
        wantHereBtnPressed!()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp()  {
        self.layoutIfNeeded()
        toView.makeRoundCorner()
        wantHereButton.makeButtonAllRoundCorner()

    }
    
}
