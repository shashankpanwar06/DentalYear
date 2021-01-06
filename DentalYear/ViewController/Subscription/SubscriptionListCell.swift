//
//  SubscriptionListCell.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class SubscriptionListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(lbl:String) {
        lblTitle.text = lbl
    }
    
}
