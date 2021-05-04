//
//  APIHandler.swift
//  DentalYear
//
//  Created by Globizserve on 07/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


class APHandler {
    
    public var didFinishSuccessfullyCallback : ((_ responseObject: AnyObject?) -> Void)?
    
    public let baseUrl = "https://dentalyear.com/wp-json/wp/v2/"
    static let shared: APHandler = {
        let instance = APHandler.init()
        return instance
    }() 
    
    //    func getTokenFromCookie(cookie:String) -> String {
    //        return String(cookie.split(separator:";")[0].split(separator: "=")[1])
    //    }
    
    func handleDidFinishedWithResponse(response: AnyObject!) {
        SVProgressHUD.dismiss()
        
        DispatchQueue.main.async {
            if self.didFinishSuccessfullyCallback != nil {
                self.didFinishSuccessfullyCallback!(response)
            }
        }
    }
    
    func handleDidFinishedWithError(error: Error!) {
        
        //        self.safeCallDidFinishWithErrorCallback(error: error as AnyObject)
        
        SVProgressHUD.dismiss()
    }
    
    //MARK: Request
    func makeGetAPIRequest(url:String , isSVProgressHudNeedToDisplay : Bool = true) {
        if isSVProgressHudNeedToDisplay{
            SVProgressHUD.show()
        }
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        AF.request(urlRequest).validate().responseJSON(completionHandler: { (response) in
            switch (response.result) {
            case .success:
                print(response)
                self.handleDidFinishedWithResponse(response: response as AnyObject)
                break
            case .failure:
                guard case let .failure(error) = response.result else { return }
                print("API Failure")
                self.handleDidFinishedWithError(error: error)
            }
        })
        
//        Alamofire.request(url, method:.get, encoding: JSONEncoding.default, headers:nil).responseJSON {
//            response in
//            switch (response.result) {
//            case .success:
//                print(response)
//                self.handleDidFinishedWithResponse(response: response as AnyObject)
//                break
//            case .failure:
//                guard case let .failure(error) = response.result else { return }
//                self.handleDidFinishedWithError(error: error)
//            }
//        }

    }
    
    
}
