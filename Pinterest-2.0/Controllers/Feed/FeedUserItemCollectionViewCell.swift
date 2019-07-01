//
//  FeedUserItemCollectionViewCell.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class FeedUserItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var imgFeed: UIImageView!
    @IBOutlet fileprivate weak var lblCaption: UILabel!
    @IBOutlet fileprivate weak var lblLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    var objectFeed = FeedBE(){
        didSet{
            self.updateData()
        }
    }
    
    func updateData(){
        self.lblCaption.text = self.objectFeed.feed_caption
        self.lblLikes.text = "Likes: \(String(self.objectFeed.feed_likes))"
        self.imgFeed.downloadImagenInUrl(self.objectFeed.feed_url, withPlaceHolderImage: nil) { (url, image) in
            if url == self.objectFeed.feed_url {
                self.imgFeed.image = image
            }
        }
        
    }
}
