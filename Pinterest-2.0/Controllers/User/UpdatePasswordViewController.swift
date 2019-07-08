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
    @IBOutlet weak var loadingPass : UIActivityIndicatorView!
    
    var objectUser = UserBE()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectUser = UserBE.object(UserDefaults.standard.value(forKey: "session") as! [String : Any])
    }
    
    @IBAction func clickBtnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        sender.isEnabled = false
        self.loadingPass.startAnimating()
        UserBL.updatePassUser(id: self.objectUser.user_id, oldPass: self.txtPass.text, newPass: self.txtNewPass.text, { (message) in
            self.showAltert(withTitle: message, withMessage: "Por favor vuelve a iniciar sesion", withAcceptButton: "ok", withCompletion: {
                sender.isEnabled = true
                self.loadingPass.stopAnimating()
                UserDefaults.standard.removeObject(forKey: "session")
                self.navigationController?.popToRootViewController(animated: true)
            })
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {
                sender.isEnabled = true
                self.loadingPass.stopAnimating()
            })
        }
    }

}
