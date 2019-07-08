//
//  UserAccountViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UserAccountViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblNick: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var imagePicker: ImagePicker!
    var objectUser = UserBE()
    
    func updateUser(){
        self.objectUser = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        self.lblNick.text = self.objectUser.user_nick
        self.lblName.text = self.objectUser.user_name
        self.lblMail.text = "Correo:\n\(self.objectUser.user_mail)"
        self.lblDate.text = "Usuario desde:\n\(formatter.string(from: self.objectUser.user_date))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        updateUser()
        self.userImg.downloadImagenInUrl(self.objectUser.user_url, withPlaceHolderImage: nil) { (url, image) in
            if url == self.objectUser.user_url {
                self.userImg.image = image
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUser()
    }
    
    @IBAction func btnImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "session")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension UserAccountViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if(image != nil){
            UserBL.updateImgUser(id: self.objectUser.user_id, img: image, { (message) in
                self.updateUser()
                self.userImg.downloadImagenInUrl(self.objectUser.user_url, withPlaceHolderImage: nil) { (url, image) in
                    if url == self.objectUser.user_url {
                        self.userImg.image = image
                    }
                }
            }) { (message) in
                self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: nil)
            }
        }
    }
}
