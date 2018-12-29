//
//  SignOutVC.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/28/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import Firebase

class SignOutVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let username = Auth.auth().currentUser?.displayName else { return }
        label.text = "Hello \(username)"
        
    }
    
    @IBAction func onSignOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
        } catch {
            print(error)
        }
    }
    
    

}
