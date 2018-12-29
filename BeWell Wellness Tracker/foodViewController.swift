//
//  foodViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/29/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit

class foodViewController: UIViewController {

   let defaults = UserDefaults.standard
    
  
    @IBOutlet weak var outputLabel: UILabel!
    //Counter outlets
    @IBOutlet weak var counterViewFood: CounterViewFood!
    @IBOutlet weak var counterLabel: UILabel!

    
   override func viewDidLoad() {
        super.viewDidLoad()
   
        let val = defaults.integer(forKey: "exerciseGoal")
        outputLabel.text = "\(val) hours of exercise"

        // Do any additional setup after loading the view.
   //     counterLabel.text = defaults.string(forKey: "currFood")
   //    counterViewFood.counter = defaults.integer(forKey: "currFood")
    

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            counterViewFood.counter += 100
        } else {
            if counterViewFood.counter > 0 {
                counterViewFood.counter -= 100
            }
        }
        counterLabel.text = String(counterViewFood.counter)
        defaults.set(counterViewFood.counter, forKey: "currFood")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
