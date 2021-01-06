//
//  SubscriptionDetails.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class SubscriptionDetails: UIViewController {
    var closeBtnBtnPressed:(()->Void)?
    var termsBtnBtnPressed:(()->Void)?
    var privacyBtnBtnPressed:(()->Void)?
    



    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 15
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func onBtnClose(_ sender: Any) {
        self.closeBtnBtnPressed!()
    }
    
    @IBAction func onBtnTerms(_ sender: Any) {
        self.termsBtnBtnPressed!()

    }
    @IBAction func onBtnPrivacy(_ sender: Any) {
        self.privacyBtnBtnPressed!()

    }
}
