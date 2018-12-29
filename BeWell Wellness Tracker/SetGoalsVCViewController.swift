//
//  SetGoalsVCViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 11/26/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import Firebase

class SetGoalsVCViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var isLoadingViewController = false

    
    @IBOutlet weak var hydrationText: UITextField!
    
    @IBOutlet weak var nutritionText: UITextField!
    
    @IBOutlet weak var sleepText: UITextField!
    
    @IBAction func nextClicked(_ sender: Any) {
        getValues()
    }
    
    func getValues(){
        defaults.set(hydrationText.text, forKey: "hydrationGoal")
        defaults.set(nutritionText.text, forKey: "exerciseGoal")
        defaults.set(sleepText.text, forKey: "sleepGoal")
    }
    
    override func viewDidLoad() {
        isLoadingViewController = true
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingViewController {
            isLoadingViewController = false
        } else {
           viewDidLoad()
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // [END get_collection]
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

