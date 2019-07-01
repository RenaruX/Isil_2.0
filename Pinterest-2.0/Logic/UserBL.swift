//
//  UserBL.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UserBL: NSObject {
    typealias SuccessArr = (_ array: [UserBE], _ message: String) -> Void
    typealias SuccessRes = (_ response: UserBE, _ message: String) -> Void
    typealias Success = (_ message: String) -> Void
    typealias Error = (_ message: String) -> Void
    
    class func loginUser(nick: String, password: String, _ success: @escaping Success, _ fail: @escaping Error){
        UserWS.loginUser(nick: nick, password: password, { (user, message) in
            let dictionary = UserBE.dictionary(user)
            UserDefaults.standard.set(dictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func registerUser(name: String, mail: String, nick: String, password: String, img: UIImage, _ success: @escaping Success, _ fail: @escaping Error){
        UserWS.setUser(name: name, mail: mail, nick: nick, password: password, img: img, { (user, message) in
            let dictionary = UserBE.dictionary(user)
            UserDefaults.standard.set(dictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func updateUser(id: Int, name: String, nick: String, mail: String, _ success: @escaping Success, _ fail: @escaping Error){
        UserWS.updateUser(id: id, name: name, nick: nick, mail: mail, { (message) in
            let object = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
            object.user_name = name
            object.user_nick = nick
            object.user_mail = mail
            let newDictionary = UserBE.dictionary(object)
            UserDefaults.standard.set(newDictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func updateImgUser(id: Int, img: UIImage, _ success: @escaping Success, _ fail: @escaping Error){
        UserWS.updateImgUser(id: id, img: img, { (url, message) in
            let object = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
            object.user_url = "https://peruvianwit.com/api/\(url)"
            let newDictionary = UserBE.dictionary(object)
            UserDefaults.standard.set(newDictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func updatePassUser(id: Int, oldPass: String, newPass: String, _ success: @escaping Success, _ fail: @escaping Error){
        UserWS.updatePassUser(id: id, oldPass: oldPass, newPass: newPass, { (message) in
            UserDefaults.standard.removeObject(forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
}
