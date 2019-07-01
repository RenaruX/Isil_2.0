//
//  AddFeedViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController {

    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var txtCaption: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    @IBAction func btnImgUpload(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func btnCreateFeed(_ sender: UIButton) {
        sender.isEnabled = false
        let currentUser = UserDefaults.standard.value(forKey: "session") as! [String : Any]
        FeedBL.setFeed(caption: self.txtCaption.text ?? "", description: self.txtDescription.text ?? "", user: currentUser["user_id"] as! Int, img: imgFeed.image ?? UIImage(), { (feed, message) in
            self.navigationController?.popViewController(animated: true)
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {sender.isEnabled = true})
        }
    }
}
extension AddFeedViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if(image != nil){
            self.imgFeed.image = image
        }
    }
}
