//
//  HomeStaticData.swift
//  DentalYear
//
//  Created by Globizserve on 08/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit

enum CellType:String {
    case kHowToCelebrate = "How To Celebrate?" //0
    case kShareWithTeamMember = "Share With Team Member"//1
    case kDailyMarketingTip = "Daily Marketing Tip" //2
    case kDailyPost = "Daily Post" //3
    case kHowToMaximizePost = "How To Maximize Post?" //4
    case kWeeklyMarketingExercise = "Weekly Marketing Exercise" //5
    case kMarketingTrendsNews = "Marketing Trends & News" //6
    case kAdOfTheMonth = "Ad Of The Month" //7
    case kThisDateInHistory = "This Date In History" //8
    case kIndustryEvents = "Industry Events" //9
    case kLookingAhead = "Looking Ahead" //10
    
    
    
    static let allValues = [kHowToCelebrate,kShareWithTeamMember,kDailyMarketingTip,kDailyPost,kHowToMaximizePost,kWeeklyMarketingExercise,kAdOfTheMonth,kMarketingTrendsNews,kThisDateInHistory,kIndustryEvents,kLookingAhead]
    
//    static let allValues = [kHowToCelebrate,kShareWithTeamMember,kDailyMarketingTip,kDailyPost,kHowToMaximizePost,kWeeklyMarketingExercise,kMarketingTrendsNews,kThisDateInHistory,kIndustryEvents,kLookingAhead]
    
}

class HomeStaticdata {
    class func getTitleFor(row:Int) -> String {
        return CellType.allValues[row].rawValue
    }
    class func getUnselectedImageFor(cellType:CellType) -> UIImage {
        
        switch cellType {
            case .kHowToCelebrate:
                return UIImage.init(named: "icCelebrate") ?? UIImage.init() //icCelebrateEx
            case .kShareWithTeamMember:
                return UIImage.init(named: "icEvents") ?? UIImage.init() //icEventsEx
            case .kDailyMarketingTip:
                return UIImage.init(named: "icTip") ?? UIImage.init() //icTipEx
            case .kDailyPost:
                return UIImage.init(named: "icPost") ?? UIImage.init() //icPostEx
            case .kHowToMaximizePost:
                return UIImage.init(named: "IcRocket") ?? UIImage.init() //icRocketEx
            case .kWeeklyMarketingExercise:
                return UIImage.init(named: "IcMarketing") ?? UIImage.init() //icMarketingEx
            case .kMarketingTrendsNews:
                return UIImage.init(named: "IcTrend") ?? UIImage.init() //icTrendsEx
            case .kAdOfTheMonth:
                return UIImage.init(named: "icAdd") ?? UIImage.init()
            case .kThisDateInHistory:
                return UIImage.init(named: "icHistory") ?? UIImage.init() //icHistoryEx
            case .kIndustryEvents:
                return UIImage.init(named: "icEvents") ?? UIImage.init() //icEventsEx
            case .kLookingAhead:
                return UIImage.init(named: "icAhead") ?? UIImage.init() //icAheadEx
        
        }
    }
    
    class func getSelectedImageFor(cellType:CellType) -> UIImage {
        switch cellType {
            case .kHowToCelebrate:
                return UIImage.init(named: "icCelebrateEx") ?? UIImage.init() //
            case .kShareWithTeamMember:
                return UIImage.init(named: "icEventsEx") ?? UIImage.init() //
            case .kDailyMarketingTip:
                return UIImage.init(named: "icTipEx") ?? UIImage.init() //
            case .kDailyPost:
                return UIImage.init(named: "icPostEx") ?? UIImage.init() //
            case .kHowToMaximizePost:
                return UIImage.init(named: "icRocketEx") ?? UIImage.init() //
            case .kWeeklyMarketingExercise:
                return UIImage.init(named: "icMarketingEx") ?? UIImage.init() //
            case .kMarketingTrendsNews:
                return UIImage.init(named: "icTrendsEx") ?? UIImage.init() //
            case .kAdOfTheMonth:
                return UIImage.init(named: "icAdd") ?? UIImage.init()
            case .kThisDateInHistory:
                return UIImage.init(named: "icHistoryEx") ?? UIImage.init() //
            case .kIndustryEvents:
                return UIImage.init(named: "icEventsEx") ?? UIImage.init() //
            case .kLookingAhead:
                return UIImage.init(named: "icAhead") ?? UIImage.init() //icAheadEx
        }
    }
    
    class func getForgroundColorFor(index:Int) -> UIColor {
        let colorArray = ["65D5FF","63B9D9","65D5FF","B9ECFF","318FB2","8BC3D8","49B2D9","41CCFF","169FD2","65D5FF","39BDEF"]
        
        return UIColor.hexStringToUIColor(hex: "#\(colorArray[index])")

    }
    class func getBackgroundColorFor(index:Int) -> UIColor {
        let colorArray = ["65D5FF","63B9D9","65D5FF","B9ECFF","318FB2","8BC3D8","49B2D9","41CCFF","169FD2","65D5FF","39BDEF"]
        
        if ((index + 1) >= colorArray.count)
        {
            return UIColor.hexStringToUIColor(hex: "#\(colorArray[0])")
        }else
        {
            return UIColor.hexStringToUIColor(hex: "#\(colorArray[index + 1])")
        }
        

    }
}
