//
//  VideoObject.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//


import Foundation
import SwiftyJSON

enum kVideoCategory:Int {
    case Fun = 5524
    case Oral = 5521
    case smile = 5518
}
public class VideoBaseObject: NSObject, NSCoding {

    

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties

    public var dataArray: [VideoObject]?


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
                dataArray?.append(VideoObject(fromJson: item))
            }
        } else {
            dataArray = nil
        }

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func arrayRepresentation() -> [VideoObject ] {

        var temp: [VideoObject] = []

        if (dataArray?.count ?? 0) > 0 {
            for item in dataArray! {
                temp.append(item)
            }
        }

        return temp
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.dataArray = aDecoder.decodeObject(forKey: "homeData") as? [VideoObject]

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dataArray, forKey: "homeData")

    }
    
    
    func getDataFor(category:kVideoCategory) -> [VideoObject] {
        
        var filterData:[VideoObject] = [VideoObject]()
        for item in dataArray! {
            if item.acf.category[0].iD == category.rawValue {
                filterData.append(item)
            }
        }
        return filterData
    }


}

public class VideoObject : NSObject, NSCoding{

//    var links : VideoLink!
    var acf : VideoAcf!
    var date : String!
    var dateGmt : String!
    var downloadVideoLink : String!
//    var guid : VideoGuid!
    var id : Int!
    var link : String!
    var modified : String!
    var modifiedGmt : String!
    var slug : String!
    var status : String!
    var template : String!
//    var title : VideoTitle!
    var type : String!
    var videoDuration : String!
    var videoLink : String!
    var videoTitle : String!
    var localUrl : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
//        let linksJson = json["_links"]
//        if !linksJson.isEmpty{
//            links = VideoLink(fromJson: linksJson)
//        }
        let acfJson = json["acf"]
        if !acfJson.isEmpty{
            acf = VideoAcf(fromJson: acfJson)
        }
        date = json["date"].stringValue
        dateGmt = json["date_gmt"].stringValue
        downloadVideoLink = json["download_video_link"].stringValue
//        let guidJson = json["guid"]
//        if !guidJson.isEmpty{
//            guid = VideoGuid(fromJson: guidJson)
//        }
        id = json["id"].intValue
        link = json["link"].stringValue
        modified = json["modified"].stringValue
        modifiedGmt = json["modified_gmt"].stringValue
        slug = json["slug"].stringValue
        status = json["status"].stringValue
        template = json["template"].stringValue
//        let titleJson = json["title"]
//        if !titleJson.isEmpty{
//            title = VideoTitle(fromJson: titleJson)
//        }
        type = json["type"].stringValue
        videoDuration = json["video_duration"].stringValue
        videoLink = json["video_link"].stringValue
        videoTitle = json["video_title"].stringValue
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
        if downloadVideoLink != nil{
            dictionary["download_video_link"] = downloadVideoLink
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
        if videoDuration != nil{
            dictionary["video_duration"] = videoDuration
        }
        if videoLink != nil{
            dictionary["video_link"] = videoLink
        }
        if videoTitle != nil{
            dictionary["video_title"] = videoTitle
        }
        if localUrl != nil{
            dictionary["localUrl"] = localUrl
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
    {
//        links = aDecoder.decodeObject(forKey: "_links") as? VideoLink
        acf = aDecoder.decodeObject(forKey: "acf") as? VideoAcf
        date = aDecoder.decodeObject(forKey: "date") as? String
        dateGmt = aDecoder.decodeObject(forKey: "date_gmt") as? String
        downloadVideoLink = aDecoder.decodeObject(forKey: "download_video_link") as? String
//        guid = aDecoder.decodeObject(forKey: "guid") as? VideoGuid
        id = aDecoder.decodeObject(forKey: "id") as? Int
        link = aDecoder.decodeObject(forKey: "link") as? String
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        modifiedGmt = aDecoder.decodeObject(forKey: "modified_gmt") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        template = aDecoder.decodeObject(forKey: "template") as? String
//        title = aDecoder.decodeObject(forKey: "title") as? VideoTitle
        type = aDecoder.decodeObject(forKey: "type") as? String
        videoDuration = aDecoder.decodeObject(forKey: "video_duration") as? String
        videoLink = aDecoder.decodeObject(forKey: "video_link") as? String
        videoTitle = aDecoder.decodeObject(forKey: "video_title") as? String
        localUrl = aDecoder.decodeObject(forKey: "localUrl") as? String

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
        if downloadVideoLink != nil{
            aCoder.encode(downloadVideoLink, forKey: "download_video_link")
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
        if videoDuration != nil{
            aCoder.encode(videoDuration, forKey: "video_duration")
        }
        if videoLink != nil{
            aCoder.encode(videoLink, forKey: "video_link")
        }
        if videoTitle != nil{
            aCoder.encode(videoTitle, forKey: "video_title")
        }
        if localUrl != nil{
            aCoder.encode(localUrl, forKey: "localUrl")
        }

    }

}



class VideoAcf : NSObject, NSCoding{

    var category : [VideoCategory]!
    var downloadVideoLink : String!
    var duration : String!
    var purchaseId : String!
    var thumbImage : String!
    var videoLink : String!
    var videoTitle : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        category = [VideoCategory]()
        if let items = json["category"].array {
            for item in items {
                category.append(VideoCategory(fromJson: item))
            }
        }
        downloadVideoLink = json["download_video_link"].stringValue
        duration = json["duration"].stringValue
        purchaseId = json["purchase_id"].stringValue
        thumbImage = json["thumb_image"].stringValue
        videoLink = json["video_link"].stringValue
        videoTitle = json["video_title"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
        var dictionaryElements = [[String:Any]]()
        for categoryElement in category {
            dictionaryElements.append(categoryElement.toDictionary())
        }
        dictionary["category"] = dictionaryElements
        }
        if downloadVideoLink != nil{
            dictionary["download_video_link"] = downloadVideoLink
        }
        if duration != nil{
            dictionary["duration"] = duration
        }
        if purchaseId != nil{
            dictionary["purchase_id"] = purchaseId
        }
        if thumbImage != nil{
            dictionary["thumb_image"] = thumbImage
        }
        if videoLink != nil{
            dictionary["video_link"] = videoLink
        }
        if videoTitle != nil{
            dictionary["video_title"] = videoTitle
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? [VideoCategory]
        downloadVideoLink = aDecoder.decodeObject(forKey: "download_video_link") as? String
        duration = aDecoder.decodeObject(forKey: "duration") as? String
        purchaseId = aDecoder.decodeObject(forKey: "purchase_id") as? String
        thumbImage = aDecoder.decodeObject(forKey: "thumb_image") as? String
        videoLink = aDecoder.decodeObject(forKey: "video_link") as? String
        videoTitle = aDecoder.decodeObject(forKey: "video_title") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if downloadVideoLink != nil{
            aCoder.encode(downloadVideoLink, forKey: "download_video_link")
        }
        if duration != nil{
            aCoder.encode(duration, forKey: "duration")
        }
        if purchaseId != nil{
            aCoder.encode(purchaseId, forKey: "purchase_id")
        }
        if thumbImage != nil{
            aCoder.encode(thumbImage, forKey: "thumb_image")
        }
        if videoLink != nil{
            aCoder.encode(videoLink, forKey: "video_link")
        }
        if videoTitle != nil{
            aCoder.encode(videoTitle, forKey: "video_title")
        }

    }

}


class VideoCategory : NSObject, NSCoding{

    var commentCount : String!
    var commentStatus : String!
    var filter : String!
    var guid : String!
    var iD : Int!
    var menuOrder : Int!
    var pingStatus : String!
    var pinged : String!
    var postAuthor : String!
    var postContent : String!
    var postContentFiltered : String!
    var postDate : String!
    var postDateGmt : String!
    var postExcerpt : String!
    var postMimeType : String!
    var postModified : String!
    var postModifiedGmt : String!
    var postName : String!
    var postParent : Int!
    var postPassword : String!
    var postStatus : String!
    var postTitle : String!
    var postType : String!
    var toPing : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        commentCount = json["comment_count"].stringValue
        commentStatus = json["comment_status"].stringValue
        filter = json["filter"].stringValue
        guid = json["guid"].stringValue
        iD = json["ID"].intValue
        menuOrder = json["menu_order"].intValue
        pingStatus = json["ping_status"].stringValue
        pinged = json["pinged"].stringValue
        postAuthor = json["post_author"].stringValue
        postContent = json["post_content"].stringValue
        postContentFiltered = json["post_content_filtered"].stringValue
        postDate = json["post_date"].stringValue
        postDateGmt = json["post_date_gmt"].stringValue
        postExcerpt = json["post_excerpt"].stringValue
        postMimeType = json["post_mime_type"].stringValue
        postModified = json["post_modified"].stringValue
        postModifiedGmt = json["post_modified_gmt"].stringValue
        postName = json["post_name"].stringValue
        postParent = json["post_parent"].intValue
        postPassword = json["post_password"].stringValue
        postStatus = json["post_status"].stringValue
        postTitle = json["post_title"].stringValue
        postType = json["post_type"].stringValue
        toPing = json["to_ping"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if commentCount != nil{
            dictionary["comment_count"] = commentCount
        }
        if commentStatus != nil{
            dictionary["comment_status"] = commentStatus
        }
        if filter != nil{
            dictionary["filter"] = filter
        }
        if guid != nil{
            dictionary["guid"] = guid
        }
        if iD != nil{
            dictionary["ID"] = iD
        }
        if menuOrder != nil{
            dictionary["menu_order"] = menuOrder
        }
        if pingStatus != nil{
            dictionary["ping_status"] = pingStatus
        }
        if pinged != nil{
            dictionary["pinged"] = pinged
        }
        if postAuthor != nil{
            dictionary["post_author"] = postAuthor
        }
        if postContent != nil{
            dictionary["post_content"] = postContent
        }
        if postContentFiltered != nil{
            dictionary["post_content_filtered"] = postContentFiltered
        }
        if postDate != nil{
            dictionary["post_date"] = postDate
        }
        if postDateGmt != nil{
            dictionary["post_date_gmt"] = postDateGmt
        }
        if postExcerpt != nil{
            dictionary["post_excerpt"] = postExcerpt
        }
        if postMimeType != nil{
            dictionary["post_mime_type"] = postMimeType
        }
        if postModified != nil{
            dictionary["post_modified"] = postModified
        }
        if postModifiedGmt != nil{
            dictionary["post_modified_gmt"] = postModifiedGmt
        }
        if postName != nil{
            dictionary["post_name"] = postName
        }
        if postParent != nil{
            dictionary["post_parent"] = postParent
        }
        if postPassword != nil{
            dictionary["post_password"] = postPassword
        }
        if postStatus != nil{
            dictionary["post_status"] = postStatus
        }
        if postTitle != nil{
            dictionary["post_title"] = postTitle
        }
        if postType != nil{
            dictionary["post_type"] = postType
        }
        if toPing != nil{
            dictionary["to_ping"] = toPing
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        commentCount = aDecoder.decodeObject(forKey: "comment_count") as? String
        commentStatus = aDecoder.decodeObject(forKey: "comment_status") as? String
        filter = aDecoder.decodeObject(forKey: "filter") as? String
        guid = aDecoder.decodeObject(forKey: "guid") as? String
        iD = aDecoder.decodeObject(forKey: "ID") as? Int
        menuOrder = aDecoder.decodeObject(forKey: "menu_order") as? Int
        pingStatus = aDecoder.decodeObject(forKey: "ping_status") as? String
        pinged = aDecoder.decodeObject(forKey: "pinged") as? String
        postAuthor = aDecoder.decodeObject(forKey: "post_author") as? String
        postContent = aDecoder.decodeObject(forKey: "post_content") as? String
        postContentFiltered = aDecoder.decodeObject(forKey: "post_content_filtered") as? String
        postDate = aDecoder.decodeObject(forKey: "post_date") as? String
        postDateGmt = aDecoder.decodeObject(forKey: "post_date_gmt") as? String
        postExcerpt = aDecoder.decodeObject(forKey: "post_excerpt") as? String
        postMimeType = aDecoder.decodeObject(forKey: "post_mime_type") as? String
        postModified = aDecoder.decodeObject(forKey: "post_modified") as? String
        postModifiedGmt = aDecoder.decodeObject(forKey: "post_modified_gmt") as? String
        postName = aDecoder.decodeObject(forKey: "post_name") as? String
        postParent = aDecoder.decodeObject(forKey: "post_parent") as? Int
        postPassword = aDecoder.decodeObject(forKey: "post_password") as? String
        postStatus = aDecoder.decodeObject(forKey: "post_status") as? String
        postTitle = aDecoder.decodeObject(forKey: "post_title") as? String
        postType = aDecoder.decodeObject(forKey: "post_type") as? String
        toPing = aDecoder.decodeObject(forKey: "to_ping") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if commentCount != nil{
            aCoder.encode(commentCount, forKey: "comment_count")
        }
        if commentStatus != nil{
            aCoder.encode(commentStatus, forKey: "comment_status")
        }
        if filter != nil{
            aCoder.encode(filter, forKey: "filter")
        }
        if guid != nil{
            aCoder.encode(guid, forKey: "guid")
        }
        if iD != nil{
            aCoder.encode(iD, forKey: "ID")
        }
        if menuOrder != nil{
            aCoder.encode(menuOrder, forKey: "menu_order")
        }
        if pingStatus != nil{
            aCoder.encode(pingStatus, forKey: "ping_status")
        }
        if pinged != nil{
            aCoder.encode(pinged, forKey: "pinged")
        }
        if postAuthor != nil{
            aCoder.encode(postAuthor, forKey: "post_author")
        }
        if postContent != nil{
            aCoder.encode(postContent, forKey: "post_content")
        }
        if postContentFiltered != nil{
            aCoder.encode(postContentFiltered, forKey: "post_content_filtered")
        }
        if postDate != nil{
            aCoder.encode(postDate, forKey: "post_date")
        }
        if postDateGmt != nil{
            aCoder.encode(postDateGmt, forKey: "post_date_gmt")
        }
        if postExcerpt != nil{
            aCoder.encode(postExcerpt, forKey: "post_excerpt")
        }
        if postMimeType != nil{
            aCoder.encode(postMimeType, forKey: "post_mime_type")
        }
        if postModified != nil{
            aCoder.encode(postModified, forKey: "post_modified")
        }
        if postModifiedGmt != nil{
            aCoder.encode(postModifiedGmt, forKey: "post_modified_gmt")
        }
        if postName != nil{
            aCoder.encode(postName, forKey: "post_name")
        }
        if postParent != nil{
            aCoder.encode(postParent, forKey: "post_parent")
        }
        if postPassword != nil{
            aCoder.encode(postPassword, forKey: "post_password")
        }
        if postStatus != nil{
            aCoder.encode(postStatus, forKey: "post_status")
        }
        if postTitle != nil{
            aCoder.encode(postTitle, forKey: "post_title")
        }
        if postType != nil{
            aCoder.encode(postType, forKey: "post_type")
        }
        if toPing != nil{
            aCoder.encode(toPing, forKey: "to_ping")
        }

    }

}
