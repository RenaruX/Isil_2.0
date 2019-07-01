//
//  RegisterViewController.swift
//  Pinterest-2.0
//
//  Created by Renato Berrocal on 6/29/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNick: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @IBAction func btnImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        sender.isEnabled = false
        UserBL.registerUser(name: self.txtName.text ?? "", mail: self.txtMail.text ?? "", nick: self.txtNick.text ?? "", password: self.txtPass.text ?? "", img: self.userImg.image ?? UIImage(), { (message) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            UIApplication.shared.delegate?.window??.rootViewController = vc
        }) { (message) in
            self.showAltert(withTitle: "ERROR", withMessage: message, withAcceptButton: "ok", withCompletion: {sender.isEnabled = true})
        }
    }
}

extension RegisterViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if(image != nil){
            self.userImg.image = image
        }
    }
}
