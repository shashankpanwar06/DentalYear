//
//  HomeDataObject.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 7, 2020

import Foundation
import SwiftyJSON

public class HomeBaseObject: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties

    public var dataArray: [HomeDataObject]?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    
    func getDataFor(country:kCountry) -> HomeDataObject {
        
        for item in dataArray! {
            if item.promptCountry == country.rawValue {
                return item
            }
        }
        return dataArray![0]
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
        
        dataArray = []
        if let items = json.array {
            for item in items {
                dataArray?.append(HomeDataObject(fromJson: item))
            }
        } else {
            dataArray = nil
        }

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func arrayRepresentation() -> [HomeDataObject ] {

        var temp: [HomeDataObject] = []

        if (dataArray?.count ?? 0) > 0 {
            for item in dataArray! {
                temp.append(item)
            }
        }

        return temp
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.dataArray = aDecoder.decodeObject(forKey: "homeData") as? [HomeDataObject]

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dataArray, forKey: "homeData")

    }

}

public class HomeDataObject : NSObject, NSCoding{

//    var links : HomeDataLink!
    var acf : HomeDataAcf!
    var dailyMarketingTip : String!
    var dailyPost : String!
    var date : String!
    var dateGmt : String!
    var guid : HomeDataGuid!
    var howToMaximizePost : String!
    var id : Int!
    var industryEvents : String!
    var link : String!
    var lookingAhead : String!
    var marketingTrendsNewsForTheDay : String!
    var modified : String!
    var modifiedGmt : String!
    var promptCountry : String!
    var promptDate : String!
    var slug : String!
    var status : String!
    var template : String!
    var thisDateInHistory : String!
    var title : HomeDataTitle!
    var todaysFunHolidayTitle : String!
    var type : String!
    var weeklyMarketingExercises : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
//        let linksJson = json["_links"]
//        if !linksJson.isEmpty{
//            links = HomeDataLink(fromJson: linksJson)
//        }
        let acfJson = json["acf"]
        if !acfJson.isEmpty{
            acf = HomeDataAcf(fromJson: acfJson)
        }
        dailyMarketingTip = json["daily_marketing_tip"].stringValue
        dailyPost = json["daily_post"].stringValue
        date = json["date"].stringValue
        dateGmt = json["date_gmt"].stringValue
        let guidJson = json["guid"]
        if !guidJson.isEmpty{
            guid = HomeDataGuid(fromJson: guidJson)
        }
        howToMaximizePost = json["how_to_maximize_post"].stringValue
        id = json["id"].intValue
        industryEvents = json["industry_events"].stringValue
        link = json["link"].stringValue
        lookingAhead = json["looking_ahead"].stringValue
        marketingTrendsNewsForTheDay = json["marketing_trends_&amp;_news_for_the_day"].stringValue
        modified = json["modified"].stringValue
        modifiedGmt = json["modified_gmt"].stringValue
        promptCountry = json["prompt_country"].stringValue
        promptDate = json["prompt_date"].stringValue
        slug = json["slug"].stringValue
        status = json["status"].stringValue
        template = json["template"].stringValue
        thisDateInHistory = json["this_date_in_history"].stringValue
        let titleJson = json["title"]
        if !titleJson.isEmpty{
            title = HomeDataTitle(fromJson: titleJson)
        }
        todaysFunHolidayTitle = json["todays_fun_holiday_title"].stringValue
        type = json["type"].stringValue
        weeklyMarketingExercises = json["weekly_marketing_exercises"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
//        if links != nil{
//            dictionary["links"] = links.toDictionary()
//        }
        if acf != nil{
            dictionary["acf"] = acf.toDictionary()
        }
        if dailyMarketingTip != nil{
            dictionary["daily_marketing_tip"] = dailyMarketingTip
        }
        if dailyPost != nil{
            dictionary["daily_post"] = dailyPost
        }
        if date != nil{
            dictionary["date"] = date
        }
        if dateGmt != nil{
            dictionary["date_gmt"] = dateGmt
        }
        if guid != nil{
            dictionary["guid"] = guid.toDictionary()
        }
        if howToMaximizePost != nil{
            dictionary["how_to_maximize_post"] = howToMaximizePost
        }
        if id != nil{
            dictionary["id"] = id
        }
        if industryEvents != nil{
            dictionary["industry_events"] = industryEvents
        }
        if link != nil{
            dictionary["link"] = link
        }
        if lookingAhead != nil{
            dictionary["looking_ahead"] = lookingAhead
        }
        if marketingTrendsNewsForTheDay != nil{
            dictionary["marketing_trends_&amp;_news_for_the_day"] = marketingTrendsNewsForTheDay
        }
        if modified != nil{
            dictionary["modified"] = modified
        }
        if modifiedGmt != nil{
            dictionary["modified_gmt"] = modifiedGmt
        }
        if promptCountry != nil{
            dictionary["prompt_country"] = promptCountry
        }
        if promptDate != nil{
            dictionary["prompt_date"] = promptDate
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if status != nil{
            dictionary["status"] = status
        }
        if template != nil{
            dictionary["template"] = template
        }
        if thisDateInHistory != nil{
            dictionary["this_date_in_history"] = thisDateInHistory
        }
        if title != nil{
            dictionary["title"] = title.toDictionary()
        }
        if todaysFunHolidayTitle != nil{
            dictionary["todays_fun_holiday_title"] = todaysFunHolidayTitle
        }
        if type != nil{
            dictionary["type"] = type
        }
        if weeklyMarketingExercises != nil{
            dictionary["weekly_marketing_exercises"] = weeklyMarketingExercises
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
    {
//        links = aDecoder.decodeObject(forKey: "_links") as? HomeDataLink
        acf = aDecoder.decodeObject(forKey: "acf") as? HomeDataAcf
        dailyMarketingTip = aDecoder.decodeObject(forKey: "daily_marketing_tip") as? String
        dailyPost = aDecoder.decodeObject(forKey: "daily_post") as? String
        date = aDecoder.decodeObject(forKey: "date") as? String
        dateGmt = aDecoder.decodeObject(forKey: "date_gmt") as? String
        guid = aDecoder.decodeObject(forKey: "guid") as? HomeDataGuid
        howToMaximizePost = aDecoder.decodeObject(forKey: "how_to_maximize_post") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        industryEvents = aDecoder.decodeObject(forKey: "industry_events") as? String
        link = aDecoder.decodeObject(forKey: "link") as? String
        lookingAhead = aDecoder.decodeObject(forKey: "looking_ahead") as? String
        marketingTrendsNewsForTheDay = aDecoder.decodeObject(forKey: "marketing_trends_&amp;_news_for_the_day") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        modifiedGmt = aDecoder.decodeObject(forKey: "modified_gmt") as? String
        promptCountry = aDecoder.decodeObject(forKey: "prompt_country") as? String
        promptDate = aDecoder.decodeObject(forKey: "prompt_date") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        template = aDecoder.decodeObject(forKey: "template") as? String
        thisDateInHistory = aDecoder.decodeObject(forKey: "this_date_in_history") as? String
        title = aDecoder.decodeObject(forKey: "title") as? HomeDataTitle
        todaysFunHolidayTitle = aDecoder.decodeObject(forKey: "todays_fun_holiday_title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        weeklyMarketingExercises = aDecoder.decodeObject(forKey: "weekly_marketing_exercises") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
//        if links != nil{
//            aCoder.encode(links, forKey: "_links")
//        }
        if acf != nil{
            aCoder.encode(acf, forKey: "acf")
        }
        if dailyMarketingTip != nil{
            aCoder.encode(dailyMarketingTip, forKey: "daily_marketing_tip")
        }
        if dailyPost != nil{
            aCoder.encode(dailyPost, forKey: "daily_post")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if dateGmt != nil{
            aCoder.encode(dateGmt, forKey: "date_gmt")
        }
        if guid != nil{
            aCoder.encode(guid, forKey: "guid")
        }
        if howToMaximizePost != nil{
            aCoder.encode(howToMaximizePost, forKey: "how_to_maximize_post")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if industryEvents != nil{
            aCoder.encode(industryEvents, forKey: "industry_events")
        }
        if link != nil{
            aCoder.encode(link, forKey: "link")
        }
        if lookingAhead != nil{
            aCoder.encode(lookingAhead, forKey: "looking_ahead")
        }
        if marketingTrendsNewsForTheDay != nil{
            aCoder.encode(marketingTrendsNewsForTheDay, forKey: "marketing_trends_&amp;_news_for_the_day")
        }
        if modified != nil{
            aCoder.encode(modified, forKey: "modified")
        }
        if modifiedGmt != nil{
            aCoder.encode(modifiedGmt, forKey: "modified_gmt")
        }
        if promptCountry != nil{
            aCoder.encode(promptCountry, forKey: "prompt_country")
        }
        if promptDate != nil{
            aCoder.encode(promptDate, forKey: "prompt_date")
        }
        if slug != nil{
            aCoder.encode(slug, forKey: "slug")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if template != nil{
            aCoder.encode(template, forKey: "template")
        }
        if thisDateInHistory != nil{
            aCoder.encode(thisDateInHistory, forKey: "this_date_in_history")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if todaysFunHolidayTitle != nil{
            aCoder.encode(todaysFunHolidayTitle, forKey: "todays_fun_holiday_title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if weeklyMarketingExercises != nil{
            aCoder.encode(weeklyMarketingExercises, forKey: "weekly_marketing_exercises")
        }

    }

}
class HomeDataTitle : NSObject, NSCoding{

    var rendered : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        rendered = json["rendered"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if rendered != nil{
            dictionary["rendered"] = rendered
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        rendered = aDecoder.decodeObject(forKey: "rendered") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if rendered != nil{
            aCoder.encode(rendered, forKey: "rendered")
        }

    }

}

class HomeDataGuid : NSObject, NSCoding{

    var rendered : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        rendered = json["rendered"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if rendered != nil{
            dictionary["rendered"] = rendered
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        rendered = aDecoder.decodeObject(forKey: "rendered") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if rendered != nil{
            aCoder.encode(rendered, forKey: "rendered")
        }

    }

}

class HomeDataAcf : NSObject, NSCoding{

    var dailyMarketingTip : String!
    var dailyPost : String!
    var sharewithTeamMember : String!
    var howToCelebrate : String!
    var howToMaximizePost : String!
    var industryEvents : String!
    var lookingAhead : String!
    var marketingTrendsNewsForTheDay : String!
    var promptCountry : String!
    var promptDate : String!
    var thisDateInHistory : String!
    var todaysFunHolidayTitle : String!
    var weeklyMarketingExercises : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        dailyMarketingTip = json["daily_marketing_tip"].stringValue
        dailyPost = json["daily_post"].stringValue
        sharewithTeamMember = json["share_with_team_member"].stringValue
        howToCelebrate = json["how_to_celebrate"].stringValue
        howToMaximizePost = json["how_to_maximize_post"].stringValue
        industryEvents = json["industry_events"].stringValue
        lookingAhead = json["looking_ahead"].stringValue
        marketingTrendsNewsForTheDay = json["marketing_trends_&_news_for_the_day"].stringValue
        promptCountry = json["prompt_country"].stringValue
        promptDate = json["prompt_date"].stringValue
        thisDateInHistory = json["this_date_in_history"].stringValue
        todaysFunHolidayTitle = json["todays_fun_holiday_title"].stringValue
        weeklyMarketingExercises = json["weekly_marketing_exercises"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dailyMarketingTip != nil{
            dictionary["daily_marketing_tip"] = dailyMarketingTip
        }
        if dailyPost != nil{
            dictionary["daily_post"] = dailyPost
        }
        if sharewithTeamMember != nil{
            dictionary["share_with_team_member"] = sharewithTeamMember
        }
        if howToCelebrate != nil{
            dictionary["how_to_celebrate"] = howToCelebrate
        }
        if howToMaximizePost != nil{
            dictionary["how_to_maximize_post"] = howToMaximizePost
        }
        if industryEvents != nil{
            dictionary["industry_events"] = industryEvents
        }
        if lookingAhead != nil{
            dictionary["looking_ahead"] = lookingAhead
        }
        if marketingTrendsNewsForTheDay != nil{
            dictionary["marketing_trends_&amp;_news_for_the_day"] = marketingTrendsNewsForTheDay
        }
        if promptCountry != nil{
            dictionary["prompt_country"] = promptCountry
        }
        if promptDate != nil{
            dictionary["prompt_date"] = promptDate
        }
        if thisDateInHistory != nil{
            dictionary["this_date_in_history"] = thisDateInHistory
        }
        if todaysFunHolidayTitle != nil{
            dictionary["todays_fun_holiday_title"] = todaysFunHolidayTitle
        }
        if weeklyMarketingExercises != nil{
            dictionary["weekly_marketing_exercises"] = weeklyMarketingExercises
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        dailyMarketingTip = aDecoder.decodeObject(forKey: "daily_marketing_tip") as? String
        dailyPost = aDecoder.decodeObject(forKey: "daily_post") as? String
        howToCelebrate = aDecoder.decodeObject(forKey: "how_to_celebrate") as? String
        sharewithTeamMember = aDecoder.decodeObject(forKey: "share_with_team_member") as? String
        howToMaximizePost = aDecoder.decodeObject(forKey: "how_to_maximize_post") as? String
        industryEvents = aDecoder.decodeObject(forKey: "industry_events") as? String
        lookingAhead = aDecoder.decodeObject(forKey: "looking_ahead") as? String
        marketingTrendsNewsForTheDay = aDecoder.decodeObject(forKey: "marketing_trends_&amp;_news_for_the_day") as? String
        promptCountry = aDecoder.decodeObject(forKey: "prompt_country") as? String
        promptDate = aDecoder.decodeObject(forKey: "prompt_date") as? String
        thisDateInHistory = aDecoder.decodeObject(forKey: "this_date_in_history") as? String
        todaysFunHolidayTitle = aDecoder.decodeObject(forKey: "todays_fun_holiday_title") as? String
        weeklyMarketingExercises = aDecoder.decodeObject(forKey: "weekly_marketing_exercises") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if dailyMarketingTip != nil{
            aCoder.encode(dailyMarketingTip, forKey: "daily_marketing_tip")
        }
        if dailyPost != nil{
            aCoder.encode(dailyPost, forKey: "daily_post")
        }
        if howToCelebrate != nil{
            aCoder.encode(howToCelebrate, forKey: "how_to_celebrate")
        }
        
        if sharewithTeamMember != nil{
            aCoder.encode(sharewithTeamMember, forKey: "share_with_team_member")
        }
        if howToMaximizePost != nil{
            aCoder.encode(howToMaximizePost, forKey: "how_to_maximize_post")
        }
        if industryEvents != nil{
            aCoder.encode(industryEvents, forKey: "industry_events")
        }
        if lookingAhead != nil{
            aCoder.encode(lookingAhead, forKey: "looking_ahead")
        }
        if marketingTrendsNewsForTheDay != nil{
            aCoder.encode(marketingTrendsNewsForTheDay, forKey: "marketing_trends_&amp;_news_for_the_day")
        }
        if promptCountry != nil{
            aCoder.encode(promptCountry, forKey: "prompt_country")
        }
        if promptDate != nil{
            aCoder.encode(promptDate, forKey: "prompt_date")
        }
        if thisDateInHistory != nil{
            aCoder.encode(thisDateInHistory, forKey: "this_date_in_history")
        }
        if todaysFunHolidayTitle != nil{
            aCoder.encode(todaysFunHolidayTitle, forKey: "todays_fun_holiday_title")
        }
        if weeklyMarketingExercises != nil{
            aCoder.encode(weeklyMarketingExercises, forKey: "weekly_marketing_exercises")
        }

    }

}

//class HomeDataLink : NSObject, NSCoding{
//
//    var about : [HomeDataAbout]!
//    var collection : [HomeDataCollection]!
//    var curies : [HomeDataCury]!
////    var self : [HomeDataSelf]!
////    var wpattachment : [HomeDataWp:attachment]!
//
//    /**
//     * Instantiate the instance using the passed json values to set the properties values
//     */
//    init(fromJson json: JSON!){
//        if json.isEmpty{
//            return
//        }
//        about = [HomeDataAbout]()
//        let aboutArray = json["about"].arrayValue
//        for aboutJson in aboutArray{
//            let value = HomeDataAbout(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        collection = [HomeDataCollection]()
//        let collectionArray = json["collection"].arrayValue
//        for collectionJson in collectionArray{
//            let value = HomeDataCollection(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        curies = [HomeDataCury]()
//        let curiesArray = json["curies"].arrayValue
//        for curiesJson in curiesArray{
//            let value = HomeDataCury(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        self = [HomeDataSelf]()
//        let selfArray = json["self"].arrayValue
//        for selfJson in selfArray{
//            let value = HomeDataSelf(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        wpattachment = [HomeDataWp:attachment]()
//        let wpattachmentArray = json["wp:attachment"].arrayValue
//        for wpattachmentJson in wpattachmentArray{
//            let value = HomeDataWp:attachment(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//    }
//
//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if about != nil{
//        var dictionaryElements = [[String:Any]]()
//        for aboutElement in about {
//            dictionaryElements.append(aboutElement.toDictionary())
//        }
//        dictionary["about"] = dictionaryElements
//        }
//        if collection != nil{
//        var dictionaryElements = [[String:Any]]()
//        for collectionElement in collection {
//            dictionaryElements.append(collectionElement.toDictionary())
//        }
//        dictionary["collection"] = dictionaryElements
//        }
//        if curies != nil{
//        var dictionaryElements = [[String:Any]]()
//        for curiesElement in curies {
//            dictionaryElements.append(curiesElement.toDictionary())
//        }
//        dictionary["curies"] = dictionaryElements
//        }
//        if self != nil{
//        var dictionaryElements = [[String:Any]]()
//        for selfElement in self {
//            dictionaryElements.append(selfElement.toDictionary())
//        }
//        dictionary["self"] = dictionaryElements
//        }
//        if wpattachment != nil{
//        var dictionaryElements = [[String:Any]]()
//        for wpattachmentElement in wpattachment {
//            dictionaryElements.append(wpattachmentElement.toDictionary())
//        }
//        dictionary["wpattachment"] = dictionaryElements
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//        about = aDecoder.decodeObject(forKey: "about") as? [HomeDataAbout]
//        collection = aDecoder.decodeObject(forKey: "collection") as? [HomeDataCollection]
//        curies = aDecoder.decodeObject(forKey: "curies") as? [HomeDataCury]
//        self = aDecoder.decodeObject(forKey: "self") as? [HomeDataSelf]
//        wpattachment = aDecoder.decodeObject(forKey: "wp:attachment") as? [HomeDataWp:attachment]
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    func encode(with aCoder: NSCoder)
//    {
//        if about != nil{
//            aCoder.encode(about, forKey: "about")
//        }
//        if collection != nil{
//            aCoder.encode(collection, forKey: "collection")
//        }
//        if curies != nil{
//            aCoder.encode(curies, forKey: "curies")
//        }
//        if self != nil{
//            aCoder.encode(self, forKey: "self")
//        }
//        if wpattachment != nil{
//            aCoder.encode(wpattachment, forKey: "wp:attachment")
//        }
//
//    }
//
//}

//class HomeDataWp:attachment : NSObject, NSCoding{
//
//    var href : String!
//
//    /**
//     * Instantiate the instance using the passed json values to set the properties values
//     */
//    init(fromJson json: JSON!){
//        if json.isEmpty{
//            return
//        }
//        href = json["href"].stringValue
//    }
//
//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if href != nil{
//            dictionary["href"] = href
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//        href = aDecoder.decodeObject(forKey: "href") as? String
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    func encode(with aCoder: NSCoder)
//    {
//        if href != nil{
//            aCoder.encode(href, forKey: "href")
//        }
//
//    }
//
//}


//class HomeDataSelf : NSObject, NSCoding{
//
//    var href : String!
//
//    /**
//     * Instantiate the instance using the passed json values to set the properties values
//     */
//    init(fromJson json: JSON!){
//        if json.isEmpty{
//            return
//        }
//        href = json["href"].stringValue
//    }
//
//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if href != nil{
//            dictionary["href"] = href
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//        href = aDecoder.decodeObject(forKey: "href") as? String
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    func encode(with aCoder: NSCoder)
//    {
//        if href != nil{
//            aCoder.encode(href, forKey: "href")
//        }
//
//    }
//
//}

class HomeDataCury : NSObject, NSCoding{

    var href : String!
    var name : String!
    var templated : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        href = json["href"].stringValue
        name = json["name"].stringValue
        templated = json["templated"].boolValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if href != nil{
            dictionary["href"] = href
        }
        if name != nil{
            dictionary["name"] = name
        }
        if templated != nil{
            dictionary["templated"] = templated
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        href = aDecoder.decodeObject(forKey: "href") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        templated = aDecoder.decodeObject(forKey: "templated") as? Bool
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if href != nil{
            aCoder.encode(href, forKey: "href")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if templated != nil{
            aCoder.encode(templated, forKey: "templated")
        }

    }

}


class HomeDataCollection : NSObject, NSCoding{

    var href : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        href = json["href"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if href != nil{
            dictionary["href"] = href
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        href = aDecoder.decodeObject(forKey: "href") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if href != nil{
            aCoder.encode(href, forKey: "href")
        }

    }

}


class HomeDataAbout : NSObject, NSCoding{

    var href : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        href = json["href"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if href != nil{
            dictionary["href"] = href
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        href = aDecoder.decodeObject(forKey: "href") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if href != nil{
            aCoder.encode(href, forKey: "href")
        }

    }

}
