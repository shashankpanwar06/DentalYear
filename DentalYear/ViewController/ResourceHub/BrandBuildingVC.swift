//
//  BrandBuildingVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 20/07/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit

class BrandBuildingVC: UIViewController {
    
    var pdf1FilePath : String?
    var pdf2FilePath : String?
    var pdf3FilePath : String?
    var pdf4FilePath : String?
    
    @IBOutlet weak var pdf1NameLbl: UILabel!
    @IBOutlet weak var pdf2NameLbl: UILabel!
    @IBOutlet weak var pdf3NameLbl: UILabel!
    @IBOutlet weak var pdf4NameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllFilePaths()
//        getBrandBuildingFiles()
    }
    
//    private func getBrandBuildingFiles(){
//        let docPath = Bundle.main.paths(forResourcesOfType: "pdf", inDirectory: "BrandBuilding")
//        let fileManager = FileManager.default
//
//        do{
////            let docArray = try fileManager.contentsOfDirectory(atPath: docPath)
////            print(docArray.count)
//        }catch{
//            print(error)
//        }
//    }
    
    private func setAllFilePaths(){
        if let pdf1Path = Bundle.main.path(forResource: "123 Dental Slogans", ofType: "pdf"){
            pdf1FilePath = pdf1Path
            pdf1NameLbl.text = "123 Dental Slogans"
        }
        
        if let pdf2Path = Bundle.main.path(forResource: "Color Meanings for Dental Brands", ofType: "pdf"){
            pdf2FilePath = pdf2Path
            pdf2NameLbl.text = "Color Meanings for Dental Brands"
        }
        
        if let pdf3Path = Bundle.main.path(forResource: "Video Filming", ofType: "pdf"){
            pdf3FilePath = pdf3Path
            pdf3NameLbl.text = "Video Filming"
        }
        
        if let pdf4Path = Bundle.main.path(forResource: "Content To Film", ofType: "pdf"){
            pdf4FilePath = pdf4Path
            pdf4NameLbl.text = "Content To Film"
        }
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pdf1BtnPressed(_ sender: UIButton) {
        if let pdfPath = pdf1FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
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
    
    @IBAction func pdf3BtnPressed(_ sender: UIButton){
        if let pdfPath = pdf3FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
    @IBAction func pdf4BtnPressed(_ sender : UIButton){
        if let pdfPath = pdf4FilePath{
            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
            dc.delegate = self
            dc.presentPreview(animated: true)
        }
    }
    
}

//MARK: UIDocumentInteractionController delegates
extension BrandBuildingVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
