//
//  InboundMarketingVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 20/07/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit

class InboundMarketingVC: UIViewController {
    
    var pdf1FilePath : String?
    
    @IBOutlet weak var pdf1NameLbl: UILabel!
    
    var pdf2FilePath : String?
    
    @IBOutlet weak var pdf2NameLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setAllFilePaths()
    }
    
    private func setAllFilePaths(){
        if let pdf1Path = Bundle.main.path(forResource: "52 Blog Post Ideas", ofType: "pdf"){
            pdf1FilePath = pdf1Path
            pdf1NameLbl.text = "52 Blog Post Ideas"
        }
        
        if let pdf2Path = Bundle.main.path(forResource: "25 SEO Tasks for Dental Websites", ofType: "pdf"){
            pdf2FilePath = pdf2Path
            pdf2NameLbl.text = "25 SEO Tasks for Dental Websites"
        }
        
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
    

    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: UIDocumentInteractionController delegates
extension InboundMarketingVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
