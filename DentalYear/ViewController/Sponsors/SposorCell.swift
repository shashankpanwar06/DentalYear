//
//  SposorCell.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SDWebImage

class SposorCell: UITableViewCell {

    @IBOutlet weak var sponsorImage: UIImageView!
    @IBOutlet weak var viewInner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewInner.layer.cornerRadius = 20
        viewInner.layer.masksToBounds  = true
        viewInner.clipsToBounds = true
        
    }
    override func prepareForReuse() {
        sponsorImage.image = UIImage.init()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(sponsor:SponsorObject)
    {
        sponsorImage.sd_setImage(with: URL(string: sponsor.acf.sponsorLogo), placeholderImage: UIImage.init())
    }
    
}
