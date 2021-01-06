//
//  RoundCornerView.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 12/12/20.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

@IBDesignable
class RoundCornerView: UIView {

    @IBInspectable var cornerRadius : CGFloat = 2.0{
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 1.0{
        didSet{
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor :UIColor = UIColor.darkGray{
        didSet{
            self.layer.borderColor = self.borderColor.cgColor
        }
    }

}
