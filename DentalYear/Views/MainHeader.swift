//
//  MainHeader.swift
//  DentalYear
//
//  Created by Globizserve on 06/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class MainHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDayName: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnArrowLeft: UIButton!
    
    var countryBtnPressed:(()->Void)?
    var farwordArrowBtnPressed:(()->Void)?
    var backwardArrowBtnPressed:(()->Void)?
    var calenderBtnPressed:(()->Void)?




    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func OnBtnCountry(_ sender: Any) {
        countryBtnPressed!()
    }
    @IBAction func onBtnArraw(_ sender: Any) {
        farwordArrowBtnPressed!()
    }
    @IBAction func onBtnCalender(_ sender: Any) {
        calenderBtnPressed!()
    }

    @IBAction func onBtnArrowleft(_ sender: Any) {
        backwardArrowBtnPressed!()
    }
}
