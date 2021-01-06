//
//  SponsorsViewController.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import PINCache

class SponsorsViewController: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewContainerTable: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewInnerHeader: UIView!
    
    var dataArray:[SponsorObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTable()
        loadData()
        
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        configureView()
    }
    func configureView()  {
        viewInnerHeader.makeRoundCorner()
    }
    
    func configureTable() {
        tblList.delegate = self
        tblList.dataSource = self
        tblList.register(UINib.init(nibName: "SposorCell", bundle: Bundle.main), forCellReuseIdentifier: "SposorCell")
        tblList.register(UINib.init(nibName: "WantHereCell", bundle: Bundle.main), forCellReuseIdentifier: "WantHereCell")
    }

    func onBtnWantHere()
    {
        if let url = URL(string:"https://dentalyear.com/dental-companies/"),
                   UIApplication.shared.canOpenURL(url) {
                       UIApplication.shared.open(url, options: [:])
           }
    }
    
    func loadData()  {
        if ((PINCache.shared().object(forKey: "spnsors")) != nil)
        {
            guard let sponsorObject:SponsorBaseObject = PINCache.shared().object(forKey: "spnsors") as? SponsorBaseObject else {return}
            self.dataArray = sponsorObject.dataArray ?? []
            self.tblList.reloadData()

        }else
        {
            fetchDataFromAPI()
        }
    }
    func fetchDataFromAPI(){
        let url = APHandler.shared.baseUrl + "sponsor?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            let sponsorObject = SponsorBaseObject(json: JSON(responseObject?.data as Any))
            
            self.dataArray = sponsorObject.dataArray ?? []
            
            if (self.dataArray.count == 0) {
                return
            }
            PINCache.shared().setObject(sponsorObject, forKey: "spnsors")
            self.tblList.reloadData()
        }
    }
    
    @IBAction func refreshBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            print(CGFloat.pi)
            print(CGFloat.pi * 2.0)
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } completion: { (status) in
            UIView.animate(withDuration: 0.5) {
                sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            } completion: { (status) in
                sender.transform = .identity
            }
        }
        fetchDataFromAPI()
    }
    
    func selected(index:Int)  {
        
        guard let aSponsorsDetailsViewController:SponsorsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SponsorsDetailsViewController") as? SponsorsDetailsViewController else {return}
          aSponsorsDetailsViewController.sponsor = dataArray[index]
          self.navigationController?.pushViewController(aSponsorsDetailsViewController, animated: true)
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
