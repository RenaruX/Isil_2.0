//
//  UserBL.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UserBL: NSObject {
    typealias Success = (_ message: String) -> Void
    typealias Error = (_ message: String) -> Void
    
    class func loginUser(nick: String?, password: String?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let nick = nick, nick.trim().count != 0 else {
            fail("Ingresa un nombre de usuario")
            return
        }
        
        guard let password = password, password.trim().count != 0 else {
            fail("Ingresa una contrasena")
            return
        }
        
        UserWS.loginUser(nick: nick, password: password, { (user, message) in
            let dictionary = UserBE.dictionary(user)
            UserDefaults.standard.set(dictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func registerUser(name: String?, mail: String?, nick: String?, password: String?, img: UIImage?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let name = name, name.trim().count != 0 else {
            fail("Ingresa un nombre")
            return
        }
        
        guard let mail = mail, mail.trim().count != 0 else {
            fail("Ingresa un correo electronico")
            return
        }
        
        guard let nick = nick, nick.trim().count != 0 else {
            fail("Ingresa un nombre de usuario")
            return
        }
        
        guard let password = password, password.trim().count != 0 else {
            fail("Ingresa una contrasena")
            return
        }
        
        guard let img = img else {
            fail("Ingresa una imagen")
            return
        }
        
        UserWS.setUser(name: name, mail: mail, nick: nick, password: password, img: img, { (user, message) in
            let dictionary = UserBE.dictionary(user)
            UserDefaults.standard.set(dictionary, forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func updateUser(id: Int?, name: String?, nick: String?, mail: String?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let id = id, id != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        guard let mail = mail, mail.trim().count != 0 else {
            fail("Ingresa un correo electronico")
            return
        }
        
        guard let nick = nick, nick.trim().count != 0 else {
            fail("Ingresa un nombre de usuario")
            return
        }
        
        guard let name = name, name.trim().count != 0 else {
            fail("Ingresa un nombre")
            return
        }
        
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
    
    class func updateImgUser(id: Int?, img: UIImage?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let id = id, id != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        guard let img = img else {
            fail("Ingresa una imagen")
            return
        }
        
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
    
    class func updatePassUser(id: Int?, oldPass: String?, newPass: String?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let id = id, id != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        guard let oldPass = oldPass, oldPass.trim().count != 0 else {
            fail("Ingresa tu antigua contrasena")
            return
        }
        
        guard let newPass = newPass, newPass.trim().count != 0 else {
            fail("Ingresa tu nueva contrasena")
            return
        }
        
        UserWS.updatePassUser(id: id, oldPass: oldPass, newPass: newPass, { (message) in
            UserDefaults.standard.removeObject(forKey: "session")
            success(message)
        }) { (message) in
            fail(message)
        }
    }
}
