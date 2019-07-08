//
//  UpdateUserViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UpdateUserViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNick: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var loadingUser : UIActivityIndicatorView!
    
    var objectUser = UserBE()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectUser = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
        self.txtNick.text = self.objectUser.user_nick
        self.txtName.text = self.objectUser.user_name
        self.txtMail.text = self.objectUser.user_mail
    }
    
    @IBAction func clickBtnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        sender.isEnabled = false
        self.loadingUser.startAnimating()
        UserBL.updateUser(id:self.objectUser.user_id, name: self.txtName.text, nick: self.txtNick.text, mail: self.txtMail.text, { (message) in
            sender.isEnabled = true
            self.loadingUser.stopAnimating()
            self.navigationController?.popViewController(animated: true)
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {
                sender.isEnabled = true
                self.loadingUser.stopAnimating()
            })
        }
    }
    
}
