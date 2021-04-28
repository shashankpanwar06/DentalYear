//
//  AudioObject.swift
//  DentalYear
//
//  Created by Globizserve on 12/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//



import Foundation
import SwiftyJSON

public class AudioBaseObject: NSObject, NSCoding {

    

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties

    public var dataArray: [AudioObject]?


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
                dataArray?.append(AudioObject(fromJson: item))
            }
        } else {
            dataArray = nil
        }

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func arrayRepresentation() -> [AudioObject ] {

        var temp: [AudioObject] = []

        if (dataArray?.count ?? 0) > 0 {
            for item in dataArray! {
                temp.append(item)
            }
        }

        return temp
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.dataArray = aDecoder.decodeObject(forKey: "homeData") as? [AudioObject]

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dataArray, forKey: "homeData")

    }
    


}


public class AudioObject : NSObject, NSCoding{

    var editLast : String!
    var editLock : String!
//    var links : AudioLink!
    var track : String!
    var acf : AudioAcf!
    var date : String!
    var dateGmt : String!
//    var guid : AudioGuid!
    var id : Int!
    var link : String!
    var modified : String!
    var modifiedGmt : String!
    var slideTemplate : String!
    var slug : String!
    var status : String!
    var template : String!
//    var title : AudioTitle!
//    var track : String!
    var type : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        editLast = json["_edit_last"].stringValue
        editLock = json["_edit_lock"].stringValue
//        let linksJson = json["_links"]
//        if !linksJson.isEmpty{
//            links = AudioLink(fromJson: linksJson)
//        }
        track = json["_track"].stringValue
        let acfJson = json["acf"]
        if !acfJson.isEmpty{
            acf = AudioAcf(fromJson: acfJson)
        }
        date = json["date"].stringValue
        dateGmt = json["date_gmt"].stringValue
//        let guidJson = json["guid"]
//        if !guidJson.isEmpty{
//            guid = AudioGuid(fromJson: guidJson)
//        }
        id = json["id"].intValue
        link = json["link"].stringValue
        modified = json["modified"].stringValue
        modifiedGmt = json["modified_gmt"].stringValue
        slideTemplate = json["slide_template"].stringValue
        slug = json["slug"].stringValue
        status = json["status"].stringValue
        template = json["template"].stringValue
//        let titleJson = json["title"]
//        if !titleJson.isEmpty{
//            title = AudioTitle(fromJson: titleJson)
//        }
        track = json["track"].stringValue
        type = json["type"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if editLast != nil{
            dictionary["_edit_last"] = editLast
        }
        if editLock != nil{
            dictionary["_edit_lock"] = editLock
        }
//        if links != nil{
//            dictionary["links"] = links.toDictionary()
//        }
        if track != nil{
            dictionary["_track"] = track
        }
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
        if slideTemplate != nil{
            dictionary["slide_template"] = slideTemplate
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
//        if title != nil{
//            dictionary["title"] = title.toDictionary()
//        }
        if track != nil{
            dictionary["track"] = track
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
        editLast = aDecoder.decodeObject(forKey: "_edit_last") as? String
        editLock = aDecoder.decodeObject(forKey: "_edit_lock") as? String
//        links = aDecoder.decodeObject(forKey: "_links") as? AudioLink
        track = aDecoder.decodeObject(forKey: "_track") as? String
        acf = aDecoder.decodeObject(forKey: "acf") as? AudioAcf
        date = aDecoder.decodeObject(forKey: "date") as? String
        dateGmt = aDecoder.decodeObject(forKey: "date_gmt") as? String
//        guid = aDecoder.decodeObject(forKey: "guid") as? AudioGuid
        id = aDecoder.decodeObject(forKey: "id") as? Int
        link = aDecoder.decodeObject(forKey: "link") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        modifiedGmt = aDecoder.decodeObject(forKey: "modified_gmt") as? String
        slideTemplate = aDecoder.decodeObject(forKey: "slide_template") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        template = aDecoder.decodeObject(forKey: "template") as? String
//        title = aDecoder.decodeObject(forKey: "title") as? AudioTitle
        track = aDecoder.decodeObject(forKey: "track") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if editLast != nil{
            aCoder.encode(editLast, forKey: "_edit_last")
        }
        if editLock != nil{
            aCoder.encode(editLock, forKey: "_edit_lock")
        }
//        if links != nil{
//            aCoder.encode(links, forKey: "_links")
//        }
        if track != nil{
            aCoder.encode(track, forKey: "_track")
        }
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
        if slideTemplate != nil{
            aCoder.encode(slideTemplate, forKey: "slide_template")
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
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
        if track != nil{
            aCoder.encode(track, forKey: "track")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}


public class AudioAcf : NSObject, NSCoding{

    var track : String!
    var videourl : String!
    var videoThumbnail : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        track = json["track"].stringValue
        videourl = json["videourl"].stringValue
        videoThumbnail = json["video_thumbnail"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if track != nil{
            dictionary["track"] = track
            dictionary["videourl"] = videourl
            dictionary["video_thumbnail"] = videoThumbnail
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
    {
        track = aDecoder.decodeObject(forKey: "track") as? String
        videourl = aDecoder.decodeObject(forKey: "videourl") as? String
        videoThumbnail = aDecoder.decodeObject(forKey: "video_thumbnail") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if track != nil{
            aCoder.encode(track, forKey: "track")
            aCoder.encode(videourl, forKey: "videourl")
            aCoder.encode(videourl, forKey: "video_thumbnail")
        }

    }

}
