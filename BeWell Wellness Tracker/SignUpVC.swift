//
//  SignUpVC.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/28/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        guard let username = usernameTF.text,
        username != "",
        let email = emailTF.text,
        email != "",
        let password = passwordTF.text,
        password != ""
        else {
            AlertController.showAlert(self, title: "Missing info", message: "Please fill out all fields")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            print(user.user.email ?? " MISSING EMAIL")
            print(user.user.uid)
            
             let changeRequest = user.user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            })
        })
    }
}
