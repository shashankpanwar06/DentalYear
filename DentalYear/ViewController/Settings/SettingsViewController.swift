//
//  SettingsViewController.swift
//  DentalYear
//
//  Created by Globizserve on 09/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import PINCache
import ActionSheetPicker_3_0
import MessageUI
let kCountryKey:String = "Country"
class SettingsViewController: UIViewController {

    @IBOutlet weak var btnRestore: UIButton!
    @IBOutlet weak var btnFeedback: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewTopheader: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func privacyTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://dentalyear.com/privacy/"){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func onBtnRestore(_ sender: Any) {
    }
    @IBAction func onBtnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBtnCountry(_ sender: Any) {
        
        
        let actionsheet:ActionSheetStringPicker = ActionSheetStringPicker.init(title: "Select Country", rows: kCountry.allValuesStrings, initialSelection: 0, doneBlock: { (picker, index, value) in
            PINCache.shared().setObject(kCountry.allValuesStrings[index] as NSCoding, forKey: kCountryKey)
            self.btnCountry.setTitle(value as? String, for: .normal)
        }, cancel: { (picker) in
            return
        }, origin: sender)
        actionsheet.toolbarButtonsColor = HomeStaticdata.getForgroundColorFor(index: 3)
        actionsheet.show()

        
    }
    

    @IBAction func onBtnShare(_ sender: Any) {
        let textToShare = "Dental Year is the best way to generate fun, social, and exciting content for your dental practice. Check it out!"
        if let myWebsite = URL(string: "http://dentalyear.com") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            if (activityVC.popoverPresentationController != nil){
                activityVC.popoverPresentationController?.sourceView = self.view
                activityVC.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
            }
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func onBtnFeedback(_ sender: Any) {
        
//        Linking.openURL('mailto:info@dentalyear.com?subject=Dental Year Feedback')
        
        if MFMailComposeViewController.canSendMail() {
               let mail = MFMailComposeViewController()
               mail.mailComposeDelegate = self
               mail.setToRecipients(["you@yoursite.com"])
               mail.setSubject("Dental Year Feedback")
               present(mail, animated: true)
           } else {
               print("Application is not able to send an email")
           }

    }
    func configureView()
    {
        viewTopheader.makeRoundCorner()
        viewPrivacy.makeAllRoundCorner()
        viewShare.makeAllRoundCorner()
        viewCountry.makeAllRoundCorner()
        btnCountry.makeButtonAllRoundCorner()
        btnShare.makeButtonAllRoundCorner()
        btnFeedback.makeButtonAllRoundCorner()
        guard let countryString:String =  PINCache.shared().object(forKey: kCountryKey) as? String else { return}
        btnCountry.setTitle(countryString, for: .normal)
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

extension SettingsViewController:MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
