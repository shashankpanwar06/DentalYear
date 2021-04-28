//
//  HomeViewController.swift
//  DentalYear
//
//  Created by Globizserve on 06/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import PINCache
import DatePickerDialog
enum kCountry:String {
    case kCanada = "Canada" //0
    case kUnitedStates = "United States" //1
    case kAustralia = "Australia" //2
    static let allValues = [kUnitedStates,kCanada,kAustralia]
    static let allValuesStrings = [kUnitedStates.rawValue,kCanada.rawValue,kAustralia.rawValue]

    
}
class HomeViewController: UIViewController {
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var dataArray: HomeBaseObject?
    var dataObject: HomeDataObject?
    var selectedCell:Int = -1
    var selectedCountry: kCountry = .kUnitedStates
    
    
    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hidesBottomBarWhenPushed = true
//        self.navigationController?.hidesBottomBarWhenPushed = true
        configureView()
        configureTable()
        fetchDataForToday()
        AppStoreReviewManager.requestReviewIfAppropriate()
    }
    
    func fetchDataForToday()  {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let todaysDate = dateFormatter.string(from: date)
        MakeApiRequestFor(date: todaysDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableForCountryChange()
        fetchDataForToday()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if FRadioPlayer.shared.isPlaying
        {
            FRadioPlayer.shared.pause()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureView()  {
        
        leftBarButtonItem.image = UIImage.init(named: "icLeftNav")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.image = UIImage.init(named: "icMore")?.withRenderingMode(.alwaysOriginal)
        self.view.backgroundColor = HomeStaticdata.getForgroundColorFor(index: 0)
        let logo = UIImage(named: "navTitle")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        guard let countryString:String =  PINCache.shared().object(forKey: kCountryKey) as? String
            else {
            selectedCountry = .kUnitedStates
            return
        }
        selectedCountry = kCountry.init(rawValue: countryString) ?? .kUnitedStates

    }
    
    func reloadTableForCountryChange()  {
        
        guard let countryString:String =  PINCache.shared().object(forKey: kCountryKey) as? String
            else {
            selectedCountry = .kUnitedStates
            return
        }
        if selectedCountry.rawValue != countryString {
            selectedCountry = kCountry.init(rawValue: countryString) ?? .kUnitedStates
            getDatafor(country: selectedCountry)
            tblList.delegate = self
            tblList.dataSource = self
            selectedCell = -1
            self.tblList.reloadData()
        }
    }
    
    func configureTable()
    {
        tblList.backgroundColor = UIColor.clear
        tblList.separatorStyle = UITableViewCell.SeparatorStyle.none
        tblList.register(UINib.init(nibName: "MainHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "MainHeader")
        tblList.register(UINib.init(nibName: "HomeCell", bundle: Bundle.main), forCellReuseIdentifier: "HomeCell")
        tblList.tableFooterView = UIView.init(frame: CGRect.zero)
        tblList.tableHeaderView = UIView.init(frame: CGRect.zero)
        self.tblList.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: -30, right: 0);
        tblList.delegate = self
        tblList.dataSource = self
    }
    
    @IBAction func onBtnSettings(_ sender: Any) {
        
        guard let  aSettings:SettingsViewController =  self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
    
        self.navigationController?.pushViewController(aSettings, animated: true)
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        guard let  aSettings:NotesViewController =  self.storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController else { return }
    
        self.navigationController?.pushViewController(aSettings, animated: true)
    }
    
    func MakeApiRequestFor(date:String)  {

//        if ((PINCache.shared().object(forKey: date)) != nil)
//        {
//            self.dataArray = PINCache.shared().object(forKey: date) as? HomeBaseObject
//            self.ReloadViewAndTable(date: date)
//        }else
//        {
            let url = APHandler.shared.baseUrl + "prompt?filter[meta_key]=prompt_date&filter[meta_value]=\(date)"
            let apiHandler:APHandler = APHandler.init()
            apiHandler.makeGetAPIRequest(url: url)
            apiHandler.didFinishSuccessfullyCallback = { response in
                let responseObject = response as? AFDataResponse<Any>
                self.dataArray = HomeBaseObject(json: JSON(responseObject?.data as Any))
                if self.dataArray == nil {
                    return
                }
                if (self.dataArray?.dataArray!.count)! == 0 {
                    return
                }
//                PINCache.shared().setObject(self.dataArray!, forKey: date)
                self.ReloadViewAndTable(date: date)
            }
//        }
    }
    
    func ReloadViewAndTable(date:String)  {
        getDatafor(country: selectedCountry)

        selectedCell = -1
        self.tblList.reloadData()
    }
    
    func getDatafor(country:kCountry)  {
        dataObject = dataArray?.getDataFor(country: country)
    }
    
    
    func cellSelectedat(index:IndexPath)  {
        if selectedCell != index.row {
            if selectedCell == -1 {

                selectedCell = index.row
                let indexPathsToReload = [index]
                tblList.reloadRows(at: indexPathsToReload, with: .automatic)
            }else
            {
                let preIndexPath = IndexPath(row: selectedCell, section: 0)
                selectedCell = index.row
                let indexPathsToReload = [index,preIndexPath]
                tblList.reloadRows(at: indexPathsToReload, with: .automatic)
                
            }
        }else
        {
            selectedCell = -1
            let indexPathsToReload = [index]
            tblList.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    func headerCountryButtonPressed()  {
    }
    
    func headerCalenderButtonPressed()  {
        DatePickerDialog.init(textColor: .black, buttonColor: HomeStaticdata.getForgroundColorFor(index: 8), font: UIFont(name: "MontserratRegular", size: 12) ?? UIFont.systemFont(ofSize: 12), locale: nil, showCancelButton: true).show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                let selectedDate = formatter.string(from: dt )
                self.MakeApiRequestFor(date: selectedDate)
                    
            }
        }
    }
    
    func headerForwardButtonPressed()  {
        let nextDate = convertNextDate(dateString: self.dataObject?.promptDate ?? "" )
        if nextDate == "" {
            return
        }
        self.MakeApiRequestFor(date: nextDate)
    }
    
    func headerBackwordButtonPressed()  {
        let nextDate = convertPreviousDate(dateString: self.dataObject?.promptDate ?? "" )
        if nextDate == "" {
            return
        }
        self.MakeApiRequestFor(date: nextDate)
    }
    
    func convertNextDate(dateString : String) -> String{
        if dateString == "" {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        return dateFormatter.string(from: tomorrow!)
    }
    
    func convertPreviousDate(dateString : String) -> String{
        if dateString == "" {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        return dateFormatter.string(from: tomorrow!)
    }
    
    func addOfMonthPlay()  {
        
    }
    
    func addOfMonthSeekTo(value:Float)  {
         
     }
    
}
