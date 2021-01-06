//
//  SponsorsDetailsViewController.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SDWebImage

class SponsorsDetailsViewController: UIViewController {
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var btnWantToBeHere: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewInnerBody: UIView!
    @IBOutlet weak var viewBosy: UIView!
    
    var sponsor:SponsorObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.tabBarController?.tabBar.isHidden = true

        self.set(sposor: sponsor!)

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Configure()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    func set(sposor:SponsorObject)  {
        imgLogo.sd_setImage(with: URL(string: sposor.acf.sponsorLogo), placeholderImage: UIImage.init())
        txtDetails.text = sposor.acf.sponsorMessage
    }
    
    func Configure()  {
        viewInnerBody.makeRoundCorner()
        btnWantToBeHere.makeButtonAllRoundCorner()
        btnSeeMore.makeButtonAllRoundCorner()
    }
    
    @IBAction func onBtnSeeMore(_ sender: Any) {
        if let url = URL(string:(sponsor?.acf.sponsorLink)! ),
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func onBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBtnWantHere(_ sender: Any) {
        
        if let url = URL(string:"https://dentalyear.com/sponsors/" ),
                  UIApplication.shared.canOpenURL(url) {
                      UIApplication.shared.open(url, options: [:])
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
