//
//  SocialMediaContentVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 10/02/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit

class SocialMediaContentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func infographicImageBtnPressed(_ sender: UIButton) {
        if let pdfPath = Bundle.main.path(forResource: "Oral Health Tips (Infographic) DY", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func infographicPDFBtnPressed(_ sender: UIButton) {
        if let pdfPath = Bundle.main.path(forResource: "Oral Health Tips (Infographic) DY", ofType: "pdf"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote1BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 1", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote2BtnPressed(_ sender: UIButton) {
        
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 2", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote3BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 3", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote4BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 4", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote5BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 5", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote6BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 6", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote7BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 7", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote8BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 8", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    
    @IBAction func smileQuote9BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 9", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote10BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 10", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote11BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 11", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func smileQuote12BtnPressed(_ sender: UIButton) {
        if let imagePath = Bundle.main.path(forResource: "QUOTE IMAGE 12", ofType: "jpg"){
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    
}


//MARK: UIDocumentInteractionController delegates
extension SocialMediaContentVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
