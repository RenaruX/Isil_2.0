//
//  UpdatePasswordViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/30/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    
    var objectUser = UserBE()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectUser = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        sender.isEnabled = false
        UserBL.updatePassUser(id: self.objectUser.user_id, oldPass: self.txtPass.text ?? "", newPass: self.txtNewPass.text ?? "", { (message) in
            self.showAltert(withTitle: message, withMessage: "Por favor vuelva a iniciar sesion", withAcceptButton: "ok", withCompletion: {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
                self.show(vc, sender: self)
            })
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {sender.isEnabled = true})
        }
    }

}
