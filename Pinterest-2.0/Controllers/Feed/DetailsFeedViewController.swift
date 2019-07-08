//
//  DetailsFeedViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class DetailsFeedViewController: UIViewController {

    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var objectFeed = FeedBE()
    
    @IBAction func clickBtnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        self.lblCaption.text = objectFeed.feed_caption
        self.lblDescription.text = objectFeed.feed_description
        self.lblAuthor.text = "Autor: \n\(objectFeed.feed_nick)"
        self.lblDate.text = "Creado el:\n\(formatter.string(from: self.objectFeed.feed_date))"
        self.imgFeed.downloadImagenInUrl(self.objectFeed.feed_url, withPlaceHolderImage: nil) { (url, image) in
            if url == self.objectFeed.feed_url {
                self.imgFeed.image = image
            }
        }
    }
}
