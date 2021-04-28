//
//  SponsorObject.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import SwiftyJSON
public class SponsorBaseObject: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties

    public var dataArray: [SponsorObject]?


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
                dataArray?.append(SponsorObject(fromJson: item))
            }
        } else {
            dataArray = nil
        }

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func arrayRepresentation() -> [SponsorObject ] {

        var temp: [SponsorObject] = []

        if (dataArray?.count ?? 0) > 0 {
            for item in dataArray! {
                temp.append(item)
            }
        }

        return temp
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.dataArray = aDecoder.decodeObject(forKey: "homeData") as? [SponsorObject]

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dataArray, forKey: "homeData")

    }

}

public class SponsorObject : NSObject, NSCoding{

//    var links : Link!
    var acf : Acf!
    var date : String!
    var dateGmt : String!
//    var guid : Guid!
    var id : Int!
    var link : String!
    var modified : String!
    var modifiedGmt : String!
    var slug : String!
    var sponsorLink : String!
    var sponsorLogo : String!
    var sponsorMessage : String!
    var sponsorName : String!
    var status : String!
    var template : String!
//    var title : Title!
    var type : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
//        let linksJson = json["_links"]
//        if !linksJson.isEmpty{
//            links = Link(fromJson: linksJson)
//        }
        let acfJson = json["acf"]
        if !acfJson.isEmpty{
            acf = Acf(fromJson: acfJson)
        }
        date = json["date"].stringValue
        dateGmt = json["date_gmt"].stringValue
//        let guidJson = json["guid"]
//        if !guidJson.isEmpty{
//            guid = Guid(fromJson: guidJson)
//        }
        id = json["id"].intValue
        link = json["link"].stringValue
        modified = json["modified"].stringValue
        modifiedGmt = json["modified_gmt"].stringValue
        slug = json["slug"].stringValue
        sponsorLink = json["sponsor_link"].stringValue
        sponsorLogo = json["sponsor_logo"].stringValue
        sponsorMessage = json["sponsor_message"].stringValue
        sponsorName = json["sponsor_name"].stringValue
        status = json["status"].stringValue
        template = json["template"].stringValue
//        let titleJson = json["title"]
//        if !titleJson.isEmpty{
//            title = Title(fromJson: titleJson)
//        }
        type = json["type"].stringValue
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
        if date != nil{
            dictionary["date"] = date
        }
        if dateGmt != nil{
            dictionary["date_gmt"] = dateGmt
        }
//        if guid != nil{
//            dictionary["guid"] = guid.toDictionary()
//        }
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
        if sponsorLink != nil{
            dictionary["sponsor_link"] = sponsorLink
        }
        if sponsorLogo != nil{
            dictionary["sponsor_logo"] = sponsorLogo
        }
        if sponsorMessage != nil{
            dictionary["sponsor_message"] = sponsorMessage
        }
        if sponsorName != nil{
            dictionary["sponsor_name"] = sponsorName
        }
        if status != nil{
            dictionary["status"] = status
        }
        if template != nil{
            dictionary["template"] = template
        }
//        if title != nil{
//            dictionary["title"] = title.toDictionary()
//        }
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
//        links = aDecoder.decodeObject(forKey: "_links") as? Link
        acf = aDecoder.decodeObject(forKey: "acf") as? Acf
        date = aDecoder.decodeObject(forKey: "date") as? String
        dateGmt = aDecoder.decodeObject(forKey: "date_gmt") as? String
//        guid = aDecoder.decodeObject(forKey: "guid") as? Guid
        id = aDecoder.decodeObject(forKey: "id") as? Int
        link = aDecoder.decodeObject(forKey: "link") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        modifiedGmt = aDecoder.decodeObject(forKey: "modified_gmt") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        sponsorLink = aDecoder.decodeObject(forKey: "sponsor_link") as? String
        sponsorLogo = aDecoder.decodeObject(forKey: "sponsor_logo") as? String
        sponsorMessage = aDecoder.decodeObject(forKey: "sponsor_message") as? String
        sponsorName = aDecoder.decodeObject(forKey: "sponsor_name") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        template = aDecoder.decodeObject(forKey: "template") as? String
//        title = aDecoder.decodeObject(forKey: "title") as? Title
        type = aDecoder.decodeObject(forKey: "type") as? String
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
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if dateGmt != nil{
            aCoder.encode(dateGmt, forKey: "date_gmt")
        }
//        if guid != nil{
//            aCoder.encode(guid, forKey: "guid")
//        }
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
        if sponsorLink != nil{
            aCoder.encode(sponsorLink, forKey: "sponsor_link")
        }
        if sponsorLogo != nil{
            aCoder.encode(sponsorLogo, forKey: "sponsor_logo")
        }
        if sponsorMessage != nil{
            aCoder.encode(sponsorMessage, forKey: "sponsor_message")
        }
        if sponsorName != nil{
            aCoder.encode(sponsorName, forKey: "sponsor_name")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if template != nil{
            aCoder.encode(template, forKey: "template")
        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}


class Acf : NSObject, NSCoding{

    var sponsorLink : String!
    var sponsorLogo : String!
    var sponsorMessage : String!
    var sponsorName : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        sponsorLink = json["sponsor_link"].stringValue
        sponsorLogo = json["sponsor_logo"].stringValue
        sponsorMessage = json["sponsor_message"].stringValue
        sponsorName = json["sponsor_name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if sponsorLink != nil{
            dictionary["sponsor_link"] = sponsorLink
        }
        if sponsorLogo != nil{
            dictionary["sponsor_logo"] = sponsorLogo
        }
        if sponsorMessage != nil{
            dictionary["sponsor_message"] = sponsorMessage
        }
        if sponsorName != nil{
            dictionary["sponsor_name"] = sponsorName
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        sponsorLink = aDecoder.decodeObject(forKey: "sponsor_link") as? String
        sponsorLogo = aDecoder.decodeObject(forKey: "sponsor_logo") as? String
        sponsorMessage = aDecoder.decodeObject(forKey: "sponsor_message") as? String
        sponsorName = aDecoder.decodeObject(forKey: "sponsor_name") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if sponsorLink != nil{
            aCoder.encode(sponsorLink, forKey: "sponsor_link")
        }
        if sponsorLogo != nil{
            aCoder.encode(sponsorLogo, forKey: "sponsor_logo")
        }
        if sponsorMessage != nil{
            aCoder.encode(sponsorMessage, forKey: "sponsor_message")
        }
        if sponsorName != nil{
            aCoder.encode(sponsorName, forKey: "sponsor_name")
        }

    }

}
