//
//  SubscriptionData.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import StoreKit
struct item {
    var title:String
    var subtitle:String
    var items:[String]
    var price:String
    var Duration:String
    var discount:String
    var product:SKProduct?
    var productId:String
    var imageTooth:String
}
class SubscriptionData {

    
    class func getSubscriptionDataArray() -> [item]
    {
        
        var items = [item]()
        let monthlyItem:item = item(title: "MONTHLY PLAN", subtitle: "30 DAYS FREE access", items: SubscriptionData.getMonthlyFeaturesList(), price: "$ 9.99", Duration: "Per Month", discount: "", productId: "com.dentalyear.monthly30FREE", imageTooth: "icLeftNav")
        items.append(monthlyItem)
        
        let yearlyItem:item = item(title: "ANNUAL PLAN", subtitle: "2 Months FREE access", items: SubscriptionData.getMonthlyFeaturesList(), price: "$ 99.99", Duration: "Per Year", discount: "$ 119.88", productId: "com.dyear.dentalyear.yr365", imageTooth: "icLeftNav")
        items.append(yearlyItem)

        return items
    }
    
    class func getMonthlyFeaturesList() -> [String] {
//        return ["Daily Fun Holidays","Daily Marketing Tips","Daily Post Ideas","Weekly Team Exercises","Ad of The Month","Dental Video Content","Industry Trends","Plus More"]
        return ["Daily Fun Holidays","Daily Marketing Tips","Daily Post Ideas","Weekly Team Exercises","Dental Video Content","Industry Trends","Plus More"]
    }
}
