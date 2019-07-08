//
//  FeedBE.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedBE: NSObject {
    var feed_id = 0
    var feed_caption = ""
    var feed_description = ""
    var feed_url = "https://peruvianwit.com/api/"
    var feed_img_height = CGFloat()
    var feed_img_width = CGFloat()
    var feed_date = Date()
    var feed_user_id = 0
    var feed_nick = ""
    var feed_likes = 0
    var liked_by_user = false
    
    class func parse(_ json: CSMJSON) -> FeedBE {
        let feed = FeedBE()
        let currentUser = UserDefaults.standard.value(forKey: "session") as! [String : Any]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        feed.feed_id = json.dictionary["id"]?.intValue ?? 0
        feed.feed_caption = json.dictionary["caption"]?.stringValue ?? ""
        feed.feed_description = json.dictionary["description"]?.stringValue ?? ""
        feed.feed_url += json.dictionary["img"]?.stringValue ?? ""
        feed.feed_img_width = CGFloat(json.dictionary["width"]?.intValue ?? 0)
        feed.feed_img_height = CGFloat(json.dictionary["height"]?.intValue ?? 0)
        feed.feed_date = formatter.date(from: json.dictionary["date"]?.stringValue ?? "") ?? Date()
        feed.feed_user_id = json.dictionary["userId"]?.intValue ?? 0
        feed.feed_nick = json.dictionary["nick"]?.stringValue ?? ""
        if(json.dictionary["likes"] != nil){
            let tempArr = json.dictionary["likes"]?.arrayValue as! [Int]
            feed.feed_likes = tempArr.count
            feed.liked_by_user = tempArr.contains(where: { $0 == currentUser["user_id"] as! Int})
        }
        return feed
    }
}
