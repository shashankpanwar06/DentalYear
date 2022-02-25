//
//  reviewCell.swift
//  DentalYear
//
//  Created by Shashank Panwar on 20/01/22.
//  Copyright © 2022 Globizserve. All rights reserved.
//

import UIKit

struct Reviewer{
    var reviewTitle : String
    var reviewDescription : String
    var reviewer : String
}

class ReviewCell: UICollectionViewCell {
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviererNameLbl: UILabel!
    @IBOutlet weak var reviewDescriptionLbl: UILabel!
    
    var review : Reviewer?{
        didSet{
            reviewTitle.text = review?.reviewTitle
            reviererNameLbl.text = review?.reviewer
            reviewDescriptionLbl.text = review?.reviewDescription
        }
    }
}
