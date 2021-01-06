//
//  FoodHolidayObject.swift
//  DentalYear
//
//  Created by Shashank Panwar on 13/12/20.
//  Copyright © 2020 Outect. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON
public class FoodHolidayBaseObject: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties

    public var dataArray: [FoodHolidayObject]?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
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
                dataArray?.append(FoodHolidayObject(fromJson: item))
            }
        } else {
            dataArray = nil
        }

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func arrayRepresentation() -> [FoodHolidayObject ] {

        var temp: [FoodHolidayObject] = []

        if (dataArray?.count ?? 0) > 0 {
            for item in dataArray! {
                temp.append(item)
            }
        }

        return temp
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.dataArray = aDecoder.decodeObject(forKey: "homeData") as? [FoodHolidayObject]

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dataArray, forKey: "homeData")

    }
    


}

public class FoodHolidayObject : NSObject, NSCoding{

    var acf : FoodHolidayACF!
    var date : String!
    var dateGmt : String!
    var id : Int!
    var link : String!
    var modified : String!
    var modifiedGmt : String!
    var slug : String!
    var status : String!
    var template : String!
    var type : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }

        let acfJson = json["acf"]
        if !acfJson.isEmpty{
            acf = FoodHolidayACF(fromJson: acfJson)
        }
        date = json["date"].stringValue
        dateGmt = json["date_gmt"].stringValue
        id = json["id"].intValue
        link = json["link"].stringValue
        modified = json["modified"].stringValue
        modifiedGmt = json["modified_gmt"].stringValue
        slug = json["slug"].stringValue

        status = json["status"].stringValue
        template = json["template"].stringValue

        type = json["type"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if acf != nil{
            dictionary["acf"] = acf.toDictionary()
        }
        if date != nil{
            dictionary["date"] = date
        }
        if dateGmt != nil{
            dictionary["date_gmt"] = dateGmt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if link != nil{
            dictionary["link"] = link
        }
        if modified != nil{
            dictionary["modified"] = modified
        }
        if modifiedGmt != nil{
            dictionary["modified_gmt"] = modifiedGmt
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
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
    {
        acf = aDecoder.decodeObject(forKey: "acf") as? FoodHolidayACF
        date = aDecoder.decodeObject(forKey: "date") as? String
        dateGmt = aDecoder.decodeObject(forKey: "date_gmt") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        link = aDecoder.decodeObject(forKey: "link") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        modifiedGmt = aDecoder.decodeObject(forKey: "modified_gmt") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        template = aDecoder.decodeObject(forKey: "template") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if acf != nil{
            aCoder.encode(acf, forKey: "acf")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if dateGmt != nil{
            aCoder.encode(dateGmt, forKey: "date_gmt")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if link != nil{
            aCoder.encode(link, forKey: "link")
        }
        if modified != nil{
            aCoder.encode(modified, forKey: "modified")
        }
        if modifiedGmt != nil{
            aCoder.encode(modifiedGmt, forKey: "modified_gmt")
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
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}


class FoodHolidayACF : NSObject, NSCoding{

    var foodHolidatyDate : String!
    var foodHoliday : String!
    var holidayDate : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        foodHolidatyDate = json["food_holiday_date"].stringValue
        foodHoliday = json["food_holiday"].stringValue
        holidayDate = json["holiday_date"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if foodHolidatyDate != nil{
            dictionary["food_holiday_date"] = foodHolidatyDate
        }
        if foodHoliday != nil{
            dictionary["food_holiday"] = foodHoliday
        }
        if holidayDate != nil{
            dictionary["holiday_date"] = holidayDate
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        foodHolidatyDate = aDecoder.decodeObject(forKey: "food_holiday_date") as? String
        foodHoliday = aDecoder.decodeObject(forKey: "food_holiday") as? String
        holidayDate = aDecoder.decodeObject(forKey: "holiday_date") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if foodHolidatyDate != nil{
            aCoder.encode(foodHolidatyDate, forKey: "food_holiday_date")
        }
        if foodHoliday != nil{
            aCoder.encode(foodHoliday, forKey: "food_holiday")
        }
        if holidayDate != nil{
            aCoder.encode(holidayDate, forKey: "holiday_date")
        }
    }

}
