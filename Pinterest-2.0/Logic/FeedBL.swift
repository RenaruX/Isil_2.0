//
//  FeedBL.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedBL: NSObject {
    typealias SuccessArr = (_ array: [FeedBE], _ message: String) -> Void
    typealias SuccessRes = (_ response: FeedBE, _ message: String) -> Void
    typealias Success = (_ message: String) -> Void
    typealias Error = (_ message: String) -> Void
    
    class func getAllFeed(_ success: @escaping SuccessArr, _ fail: @escaping Error){
        FeedWS.getAllFeed({ (arrFeed, message) in
            success(arrFeed, message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func getUserFeed(user: Int?, _ success: @escaping SuccessArr, _ fail: @escaping Error){
        guard let user = user, user != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        FeedWS.getUserFeed(user: user, { (arrFeed, message) in
            success(arrFeed, message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func setLike(id: Int?, user: Int?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let id = id, id != 0 else {
            fail("ID de feed erroneo")
            return
        }
        
        guard let user = user, user != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        FeedWS.setLike(id: id, user: user, { (message) in
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func removeLike(id: Int?, user: Int?, _ success: @escaping Success, _ fail: @escaping Error){
        guard let id = id, id != 0 else {
            fail("ID de feed erroneo")
            return
        }
        
        guard let user = user, user != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        FeedWS.removeLike(id: id, user: user, { (message) in
            success(message)
        }) { (message) in
            fail(message)
        }
    }
    
    class func setFeed(caption: String?, description: String?, user: Int?, img: UIImage?, _ success: @escaping SuccessRes, _ fail: @escaping Error){
        guard let caption = caption, caption.trim().count != 0 else {
            fail("Ingresa un titulo")
            return
        }
        
        guard let description = description, description.trim().count != 0 else {
            fail("Ingresa una descripcion")
            return
        }
        
        guard let user = user, user != 0 else {
            fail("ID de usuario erroneo")
            return
        }
        
        guard let img = img else {
            fail("Ingresa una imagen")
            return
        }
        
        FeedWS.setFeed(caption: caption, description: description, user: user, img: img, { (feed, message) in
            success(feed, message)
        }) { (message) in
            fail(message)
        }
    }
}
