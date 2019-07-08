//
//  LoginViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtNick: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var loadingLogin : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickBtnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        sender.isEnabled = false
        self.loadingLogin.startAnimating()
        
        UserBL.loginUser(nick: self.txtNick.text, password: self.txtPass.text, { (message) in
            sender.isEnabled = true
            self.loadingLogin.stopAnimating()
            self.performSegue(withIdentifier: "ShowTabBarController", sender: nil)
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {
                sender.isEnabled = true
                self.loadingLogin.stopAnimating()
            })
        }
    }
}
