//
//  HomeTableDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 06/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension HomeViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard dataObject != nil else{return UIView()}
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainHeader") as! MainHeader
        headerView.makeRoundCorner()
        headerView.lblDayName.text = dataObject!.todaysFunHolidayTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from:dataObject!.promptDate)!
        let formatterDate  = DateFormatter()
        formatterDate.dateFormat = "MMMM dd"
        headerView.lblDate.text =  formatterDate.string(from: date)
        if date >  Date()  {
            headerView.btnArrowLeft.isHidden = false
        }else
        {
            headerView.btnArrowLeft.isHidden = true
        }
        let formatterDay  = DateFormatter()
        formatterDay.dateFormat = "EEEE"
        headerView.lblDay.text =  formatterDay.string(from: date)
        headerView.calenderBtnPressed = {
            self.headerCalenderButtonPressed()
        }
        
        headerView.farwordArrowBtnPressed = {
            self.headerForwardButtonPressed()
            
        }
        
        headerView.backwardArrowBtnPressed = {
            self.headerBackwordButtonPressed()
            
        }
        
        headerView.countryBtnPressed = {
            self.headerCountryButtonPressed()
        }
        
        switch selectedCountry {
        case .kUnitedStates:
            headerView.btnCountry.setImage(UIImage(named: "icUsa"), for: .normal)
        case .kCanada:
                headerView.btnCountry.setImage(UIImage(named: "iCanada"), for: .normal)
        case .kAustralia:
                headerView.btnCountry.setImage(UIImage(named: "icAus"), for: .normal)
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 250
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        guard dataObject != nil else{return 0}
        return CellType.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.selectedCell {
            let aCell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
             let cellType = CellType.allValues[indexPath.row]
             aCell.setupCellForSelected(indexPath: indexPath, type: cellType, data: dataObject!)
//            if cellType == .kAdOfTheMonth {
//                aCell.playBtnPressed = { url in
//                    
//                    print("Play Btn Pressed in \(self)")
//                    let player = AVPlayer(url: url)
//                    let playerViewController = AVPlayerViewController()
//                    playerViewController.player = player
//                    self.present(playerViewController, animated: true) {
//                        playerViewController.player!.play()
//                    }
//                }
//                aCell.sliderValueChanged = {
//                    value in 
//                }
//            }
             
             return aCell
            
        }else
        {
            let aCell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
             let cellType = CellType.allValues[indexPath.row]
             aCell.setupCellFor(indexPath: indexPath, type: cellType, data: dataObject!)
            if cellType == .kAdOfTheMonth {
                aCell.playBtnPressed = { url in
                    
                    print("Play Btn Pressed in \(self)")
                    let player = AVPlayer(url: url)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }
                aCell.sliderValueChanged = {
                    value in
                }
            }
             return aCell
        }
 

        
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedCell == indexPath.row {
            let cellType = CellType.allValues[indexPath.row]
            let lableHeight = calCulculateCellHeightfor(indexpath: indexPath, tableView: tableView, type: cellType)
            let cellImage = HomeStaticdata.getUnselectedImageFor(cellType: cellType)
            return lableHeight  + 100 + cellImage.size.height + 200
        }else
        {
            let cellType = CellType.allValues[indexPath.row]
            if cellType == .kAdOfTheMonth{
                let lableHeight = calCulculateCellHeightfor(indexpath: indexPath, tableView: tableView, type: cellType)
                let cellImage = HomeStaticdata.getUnselectedImageFor(cellType: cellType)
                return lableHeight  + 100 + cellImage.size.height + 200
            }
            return 170
        }
        
//        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.cellSelectedat(index: indexPath)
        
    }
    
    func calCulculateCellHeightfor(indexpath:IndexPath ,tableView: UITableView,type:CellType) -> CGFloat {
        
        
        var text:String = ""
        
        switch type {
        case .kHowToCelebrate:
            text = dataObject!.acf.howToCelebrate
        case .kDailyMarketingTip:
            text = dataObject!.acf.dailyMarketingTip
        case .kShareWithTeamMember:
            text = dataObject!.acf.sharewithTeamMember
        case .kDailyPost:
            text = dataObject!.acf.dailyPost
        case .kHowToMaximizePost:
            text = dataObject!.acf.howToMaximizePost
        case .kWeeklyMarketingExercise:
            text = dataObject!.acf.weeklyMarketingExercises
        case .kMarketingTrendsNews:
            text = dataObject!.acf.marketingTrendsNewsForTheDay
        case .kThisDateInHistory:
            text = dataObject!.acf.thisDateInHistory
        case .kIndustryEvents:
            text = dataObject!.acf.industryEvents
        case .kLookingAhead:
            text = dataObject!.acf.lookingAhead
        default:
            text =  ""
        }
        
        
        return text.height(withConstrainedWidth: self.tblList.frame.width - 111, font: UIFont.init(name: "MontserratRegular", size: 12) ?? UIFont.systemFont(ofSize: 12))
        
    }

    
}
