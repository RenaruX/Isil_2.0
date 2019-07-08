//
//  SplashViewController.swift
//  Pinterest-2.0
//
//  Created by Alumno on 7/1/19.
//  Copyright © 2019 Renato Berrocal. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if(UserDefaults.standard.object(forKey: "session") == nil){
            self.performSegue(withIdentifier: "ShowToLogin", sender: nil)
        }else{
            self.performSegue(withIdentifier: "ShowTabBarController", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
