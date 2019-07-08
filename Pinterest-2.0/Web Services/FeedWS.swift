//
//  FeedWS.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedWS: NSObject {
    typealias SuccessArr = (_ array: [FeedBE], _ message: String) -> Void
    typealias SuccessRes = (_ response: FeedBE, _ message: String) -> Void
    typealias Success = (_ message: String) -> Void
    typealias Error = (_ message: String) -> Void
    
    private var endPoint = "https://peruvianwit.com/api/api.php"

    class func getAllFeed(_ success: @escaping SuccessArr, _ fail: @escaping Error){
        let feed = FeedWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "getAllFeed"
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: feed.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let arrResponse = response.JSON?.dictionary["feed"]?.array ?? []
                var arrFeed = [FeedBE]()
                for json in arrResponse{
                    let objectFeed = FeedBE.parse(json)
                    arrFeed.append(objectFeed)
                }
                success(arrFeed, message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func getUserFeed(user: Int, _ success: @escaping SuccessArr, _ fail: @escaping Error){
        let feed = FeedWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f":"getUserFeed",
            "id":user
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: feed.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let arrResponse = response.JSON?.dictionary["feed"]?.array ?? []
                var arrFeed = [FeedBE]()
                for json in arrResponse{
                    let objectFeed = FeedBE.parse(json)
                    arrFeed.append(objectFeed)
                }
                success(arrFeed, message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func setLike(id: Int, user: Int, _ success: @escaping Success, _ fail: @escaping Error){
        let feed = FeedWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f":"setLike",
            "feed":id,
            "user":user
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: feed.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                success(message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func removeLike(id: Int, user: Int, _ success: @escaping Success, _ fail: @escaping Error){
        let feed = FeedWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f":"removeLike",
            "feed":id,
            "user":user
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: feed.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                success(message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func setFeed(caption: String, description: String, user: Int, img: UIImage, _ success: @escaping SuccessRes, _ fail: @escaping Error){
        let feed = FeedWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f":"setFeed",
            "caption":caption,
            "description":description,
            "user":user,
            "img":img
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: feed.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let feed = response.JSON?.dictionary["feed"]
                let objectUser = FeedBE.parse(feed!)
                success(objectUser, message)
            }
            else{
                fail(message)
            }
        }
    }
}
