//
//  UserBE.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UserBE: NSObject {
    
    var user_id = 0
    var user_name = ""
    var user_nick = ""
    var user_mail = ""
    var user_url = "https://peruvianwit.com/api/"
    var user_date = Date()
    
    class func parse(_ json: CSMJSON) -> UserBE {
        let user = UserBE()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        user.user_id = json.dictionary["id"]?.intValue ?? 0
        user.user_name = json.dictionary["name"]?.stringValue ?? ""
        user.user_nick = json.dictionary["nick"]?.stringValue ?? ""
        user.user_mail = json.dictionary["mail"]?.stringValue ?? ""
        user.user_url += json.dictionary["img"]?.stringValue ?? ""
        user.user_date = formatter.date(from: json.dictionary["date"]?.stringValue ?? "") ?? Date()
        return user
    }
    
    class func dictionary(_ user: UserBE) -> [String : Any]{
        return [
            "user_id" : user.user_id,
            "user_name" : user.user_name,
            "user_nick" : user.user_nick,
            "user_mail" : user.user_mail,
            "user_url" : user.user_url,
            "user_date" : user.user_date
        ]
    }
    
    class func object(_ dictionary: [String : Any]) -> UserBE{
        let user = UserBE()
        user.user_id = dictionary["user_id"] as! Int
        user.user_name = dictionary["user_name"] as! String
        user.user_nick = dictionary["user_nick"] as! String
        user.user_mail = dictionary["user_mail"] as! String
        user.user_url = dictionary["user_url"] as! String
        user.user_date = dictionary["user_date"] as! Date
        return user
    }
}
