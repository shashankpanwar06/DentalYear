//
//  CustomPopUp.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class CustomPopUp: UIViewController {
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnAffirmative: UIButton!
    
    var affirmativeBtnBtnPressed:(()->Void)?
    var cancelBtnBtnPressed:(()->Void)?


    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var viewInner: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()

    }
    
    func configure()  {
        viewInner.makeRoundCornerOpposite()
        btnAffirmative.makeButtonAllRoundCorner()
        btnCancel.makeButtonAllRoundCorner()
    }
    @IBAction func onBtnAffirmative(_ sender: Any) {
        affirmativeBtnBtnPressed!()
    }
    @IBAction func onBtnCancel(_ sender: Any) {
        cancelBtnBtnPressed!()
    }
    
    func hidesAfterDelay()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
            self.dismiss(animated: true) {
            }
        }
    }
    func set(title:String,description:String,affermativeText:String,cancelText:String,showCancel:Bool,showaffermative:Bool,selfHide:Bool) {
        lblHeading.text = title
        lblDetails.text = description
        btnAffirmative.setTitle(affermativeText, for: .normal)
        btnCancel.setTitle(cancelText, for: .normal)
        btnCancel.isHidden = !showCancel
        btnAffirmative.isHidden = !showaffermative
        if selfHide {
            hidesAfterDelay()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
