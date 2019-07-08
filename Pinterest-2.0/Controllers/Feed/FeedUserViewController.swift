//
//  FeedUserViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedUserViewController: UIViewController {
    @IBOutlet weak var clvFeed: UICollectionView!
    
    var arrFeed = [FeedBE]()
    var objectUser = UserBE()
    var newFeed = FeedBE()
    
    private func getFeed(){
        FeedBL.getUserFeed(user: self.objectUser.user_id, { (feed, message) in
            self.arrFeed = feed
            self.clvFeed.reloadSections(IndexSet(integer: 0))
        }) { (message) in
            self.showAltert(withTitle: "error", withMessage: message, withAcceptButton: "reintentar", withCompletion: {
                self.getFeed()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = clvFeed.collectionViewLayout as? PinterestUserLayout {
            layout.delegate = self
        }
        self.objectUser = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
        self.getFeed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFeedViewController"{
            let add = segue.destination as! AddFeedViewController
            add.delegate = self
        }
    }
}

extension FeedUserViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFeed.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedUserItemCollectionViewCell", for: indexPath)
        if let item = cell as? FeedUserItemCollectionViewCell {
            item.objectFeed = arrFeed[indexPath.row]
        }
        return cell
    }
}

extension FeedUserViewController: PinterestUserLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let ratioHeight = (collectionView.frame.width / 2.12) * arrFeed[indexPath.row].feed_img_height / arrFeed[indexPath.row].feed_img_width
        return ratioHeight
    }
}

extension FeedUserViewController: FeedAddDelegate{
    func reload(_ object: FeedBE) {
        self.newFeed = object
        self.arrFeed.append(object)
        self.clvFeed.reloadData()
    }
}
