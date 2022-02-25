//
//  ResourceHubVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 09/02/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit
import AVKit

class ResourceHubVC: UIViewController {
    
    @IBOutlet weak var topViewHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }

    func configures(){
        self.view.layoutIfNeeded()
        topViewHeader.makeRoundCorner()
    }
    
    @IBAction func receptionSignsBtnPressed(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "ReceptionSignVC") as? ReceptionSignVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReceptionSignVC") as? ReceptionSignVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func inboundMarketingBtnPressed(_ sender: UIButton) {
//        if let pdf1Path = Bundle.main.path(forResource: "52 Blog Post Ideas", ofType: "pdf"){
//            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdf1Path))
//            dc.delegate = self
//            dc.presentPreview(animated: true)
//        }
        if #available(iOS 13.0, *) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "InboundMarketingVC") as? InboundMarketingVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InboundMarketingVC") as? InboundMarketingVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    
    @IBAction func brandBuildingBtnPressed(_ sender: UIButton) {
//        if let pdf1Path = Bundle.main.path(forResource: "123 Dental Slogans", ofType: "pdf"){
//            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdf1Path))
//            dc.delegate = self
//            dc.presentPreview(animated: true)
//        }
        
        if #available(iOS 13.0, *) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "BrandBuildingVC") as? BrandBuildingVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrandBuildingVC") as? BrandBuildingVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func socialMediaContentBtnPressed(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "SocialMediaContentVC") as? SocialMediaContentVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SocialMediaContentVC") as? SocialMediaContentVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func lunchBtnPressed(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "LunchViewController") as? LunchViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LunchViewController") as? LunchViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/dentalyear-vcl.appspot.com/o/Lunch%26Learn%2FVideo%2FDentalYearLunchAndLearnWithOutSponsorPlug_v01%20(1)%20(1)%20(1).mp4?alt=media&token=c2ad975e-0f98-43e5-afbd-67254f646867")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    @IBAction func lunchLearnButtonPresed(_ sender: UIButton) {
        guard let url = URL(string: "https://zoom.us/j/96280300120") else { return }
        UIApplication.shared.open(url)
    }
    
}

//MARK: UIDocumentInteractionController delegates
extension ResourceHubVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
