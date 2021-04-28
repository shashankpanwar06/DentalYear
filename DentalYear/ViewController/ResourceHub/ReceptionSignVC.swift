//
//  ReceptionSignVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 09/02/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit

class ReceptionSignVC: UIViewController {
    
    var pdf1FilePath : String?
    var image1FilePath : String?
    
    var pdf2FilePath : String?
    var image2FilePath : String?
    
    var pdf3FilePath : String?
    var image3FilePath : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setAllFilePaths()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    private func setAllFilePaths(){
        if let pdf1Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V1", ofType: "pdf"){
            pdf1FilePath = pdf1Path
        }
        
        if let image1Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V1", ofType: "jpg"){
            image1FilePath = image1Path
        }
        
        if let pdf1Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V2", ofType: "pdf"){
            pdf2FilePath = pdf1Path
        }
        
        if let image2Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V2", ofType: "jpg"){
            image2FilePath = image2Path
        }
        
        if let pdf1Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V3", ofType: "pdf"){
            pdf3FilePath = pdf1Path
        }
        
        if let image3Path = Bundle.main.path(forResource: "DentalYear (Check-In Sign) V3", ofType: "jpg"){
            image3FilePath = image3Path
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func image1BtnPressed(_ sender: UIButton) {
        if let imagePath = image1FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    
    @IBAction func pdf1BtnPressed(_ sender: UIButton) {
        if let pdfPath = pdf1FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func image2BtnPressed(_ sender: UIButton) {
        if let imagePath = image2FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    
    @IBAction func pdf2BtnPressed(_ sender: UIButton) {
        if let pdfPath = pdf2FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func image3BtnPressed(_ sender: UIButton) {
        if let imagePath = image3FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: imagePath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    
    @IBAction func pdf3BtnPressed(_ sender: UIButton) {
        if let pdfPath = pdf3FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
}

//MARK: UIDocumentInteractionController delegates
extension ReceptionSignVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}


