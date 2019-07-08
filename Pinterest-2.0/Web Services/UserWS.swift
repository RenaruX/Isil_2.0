//
//  UserWS.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UserWS: NSObject {
    typealias SuccessRes = (_ response: UserBE, _ message: String) -> Void
    typealias SuccessStr = (_ response: String, _ message: String) -> Void
    typealias Success = (_ message: String) -> Void
    typealias Error = (_ message: String) -> Void
    
    private var endPoint = "https://peruvianwit.com/api/api.php"
    
    class func loginUser(nick: String, password: String, _ success: @escaping SuccessRes, _ fail: @escaping Error){
        let user = UserWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "loginUser",
            "nick" : nick,
            "pass" : password
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: user.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let user = response.JSON?.dictionary["user"]
                let objectUser = UserBE.parse(user!)
                success(objectUser, message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func setUser(name: String, mail: String, nick: String, password: String, img: UIImage, _ success: @escaping SuccessRes, _ fail: @escaping Error){
        let user = UserWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "setUser",
            "name" : name,
            "pass" : password,
            "nick" : nick,
            "mail" : mail,
            "img" : img
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: user.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let user = response.JSON?.dictionary["user"]
                let objectUser = UserBE.parse(user!)
                success(objectUser, message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func updateUser(id: Int, name: String, nick: String, mail: String, _ success: @escaping Success, _ fail: @escaping Error){
        let user = UserWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "updateUser",
            "id" : id,
            "name" : name,
            "nick" : nick,
            "mail" : mail
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: user.endPoint, header: headers, parameters: params) { (response) in
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
    
    class func updateImgUser(id: Int, img: UIImage, _ success: @escaping SuccessStr, _ fail: @escaping Error){
        let user = UserWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "updateImgUser",
            "id" : id,
            "img" : img
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: user.endPoint, header: headers, parameters: params) { (response) in
            let error = response.JSON?.dictionary["error"]?.boolValue ?? true
            let message = response.JSON?.dictionary["message"]?.stringValue ?? ""
            if(!error){
                let url = response.JSON?.dictionary["newUrl"]?.stringValue ?? ""
                success(url, message)
            }
            else{
                fail(message)
            }
        }
    }
    
    class func updatePassUser(id: Int, oldPass: String, newPass: String, _ success: @escaping Success, _ fail: @escaping Error){
        let user = UserWS()
        let headers = CSMWebServiceHeaderRequest()
        let params:[String:Any] = [
            "f" : "updatePassUser",
            "id" : id,
            "oldPass" : oldPass,
            "newPass" : newPass
        ]
        headers.contentType = .formData
        CSMWebServiceManager.shared.request.postRequest(urlString: user.endPoint, header: headers, parameters: params) { (response) in
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
}
