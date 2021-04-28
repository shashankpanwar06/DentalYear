//
//  ResourceHubVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 09/02/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit

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
        if let pdf1Path = Bundle.main.path(forResource: "52 Blog Post Ideas", ofType: "pdf"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdf1Path))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
        
    }
    
    @IBAction func brandBuildingBtnPressed(_ sender: UIButton) {
        if let pdf1Path = Bundle.main.path(forResource: "123 Dental Slogans", ofType: "pdf"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdf1Path))
            dc.delegate = self
            dc.presentPreview(animated: true)
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
    
    
}

//MARK: UIDocumentInteractionController delegates
extension ResourceHubVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
