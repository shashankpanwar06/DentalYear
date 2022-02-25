//
//  SecondOnboardingVC.swift
//  DentalYear
//
//  Created by Shashank Panwar on 20/01/22.
//  Copyright © 2022 Globizserve. All rights reserved.
//

import UIKit
import Gifu

class SecondOnboardingVC: UIViewController {
    @IBOutlet weak var mainImageView: GIFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGif()
    }
    
    func loadGif(){
        mainImageView.animate(withGIFNamed: "screen-2_1", animationBlock:  {
            print("Image Load")
        })
    }

}
