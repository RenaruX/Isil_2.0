//
//  FeedListViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {
    @IBOutlet weak var clvFeed: UICollectionView!
    var arrFeed = [FeedBE]()
    var flag = false
    
    private func getFeed(){
        FeedBL.getAllFeed({ (feed, message) in
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
        if let layout = clvFeed.collectionViewLayout as? PinterestFeedLayout {
            layout.delegate = self
        }
        self.getFeed()
    }
}

extension FeedListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedItemCollectionViewCell", for: indexPath)
        if let item = cell as? FeedItemCollectionViewCell {
            item.objectFeed = self.arrFeed[indexPath.row]
            item.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailsFeedViewController", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsFeedViewController"{
            let index = sender as! IndexPath
            let details = segue.destination as! DetailsFeedViewController
            details.objectFeed = arrFeed[index.row]
        }
    }
}

extension FeedListViewController: FeedItemCellDelegate{
    func button(wasPressedOnCell cell: FeedItemCollectionViewCell) {
        let currentUser = UserDefaults.standard.value(forKey: "session") as! [String : Any]
        let indexOfFeed = self.arrFeed.firstIndex(of: cell.objectFeed) ?? -1
        if(!cell.objectFeed.liked_by_user){
            FeedBL.setLike(id: cell.objectFeed.feed_id, user: currentUser["user_id"] as? Int, { (message) in
                self.arrFeed[indexOfFeed].feed_likes += 1
                self.arrFeed[indexOfFeed].liked_by_user = true
                self.clvFeed.reloadSections(IndexSet(integer: 0))
            }) { (message) in
                self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: nil)
            }
        }
        else{
            FeedBL.removeLike(id: cell.objectFeed.feed_id, user: currentUser["user_id"] as? Int, { (message) in
                self.arrFeed[indexOfFeed].feed_likes -= 1
                self.arrFeed[indexOfFeed].liked_by_user = false
                self.clvFeed.reloadSections(IndexSet(integer: 0))
            }) { (message) in
                self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: nil)
            }
        }
    }
}
    
extension FeedListViewController: PinterestFeedLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let ratioHeight = (collectionView.frame.width / 1.63) * arrFeed[indexPath.row].feed_img_height / arrFeed[indexPath.row].feed_img_width
        return ratioHeight
    }
}


