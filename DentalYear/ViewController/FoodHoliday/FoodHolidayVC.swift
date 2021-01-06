//
//  FoodHolidayVC.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 12/12/20.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import PINCache

class FoodHolidayVC : UIViewController{
    
    @IBOutlet weak var topViewHeader: UIView!
    @IBOutlet weak var foodHolidayTableView: UITableView!
    
    var dataArray = [FoodHolidayObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
        foodHolidayTableView.delegate = self
        foodHolidayTableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configures(){
        self.view.layoutIfNeeded()
        topViewHeader.makeRoundCorner()
    }
    
    func loadData(){
        if ((PINCache.shared().object(forKey: "foodHoliday")) != nil){
            guard let foodHolidayObject:FoodHolidayBaseObject = PINCache.shared().object(forKey: "foodHoliday") as? FoodHolidayBaseObject else {return}
            configureFoodHoliday(foodHolidayObject: foodHolidayObject)
        }else{
            fetchDataFromAPI()
        }
    }
    
    func fetchDataFromAPI(){
        let url = APHandler.shared.baseUrl + "food?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            let foodHolidayObject = FoodHolidayBaseObject(json: JSON(responseObject?.data as Any))
            self.configureFoodHoliday(foodHolidayObject: foodHolidayObject)
            PINCache.shared().setObject(foodHolidayObject, forKey: "foodHoliday")
            
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
    
    
    func configureFoodHoliday(foodHolidayObject : FoodHolidayBaseObject){
        self.dataArray = foodHolidayObject.dataArray!.filter({ (foodHoliday) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let date = dateFormatter.date(from: foodHoliday.acf.holidayDate)
            let holidayMonth = Calendar(identifier: .gregorian).component(.month, from: date!)
            let holidayYear = Calendar(identifier: .gregorian).component(.year, from: date!)
            let todayMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
            let todayYear = Calendar(identifier: .gregorian).component(.year, from: Date())
            print("holiday Month : \(holidayMonth), Today Month : \(todayMonth)")
            if holidayMonth == todayMonth{
                if holidayYear == todayYear{
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }).sorted(by: {$0.acf.holidayDate < $1.acf.holidayDate})
        self.foodHolidayTableView.reloadData()
    }
}

extension FoodHolidayVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "foodHolidayCell", for: indexPath) as? FoodHolidayCellTableViewCell{
            let foodHoliday = dataArray[indexPath.row]
            cell.dateLbl.text = foodHoliday.acf.foodHolidatyDate
            cell.holidayLbl.text = foodHoliday.acf.foodHoliday
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    
}
