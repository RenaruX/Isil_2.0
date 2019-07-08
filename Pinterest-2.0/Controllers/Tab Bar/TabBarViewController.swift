//
//  TabBarViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 7/8/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let feed = viewController as? FeedListViewController{
            let source = self.viewControllers![2] as! FeedUserViewController
            if source.newFeed.feed_id != 0{
                feed.arrFeed.append(source.newFeed)
                feed.clvFeed.reloadData()
                source.newFeed = FeedBE()
            }
        }
    }
}


