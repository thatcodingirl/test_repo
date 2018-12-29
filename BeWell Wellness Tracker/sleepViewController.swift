//
//  sleepViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/29/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit

class sleepViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var counterView: CounterViewSleep!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let val = defaults.integer(forKey: "sleepGoal")
        outputLabel.text = "\(val) hours of \r\n sleep"
        
       // counterLabel.text = defaults.string(forKey: "currSleep")
      //  counterView.counter = defaults.integer(forKey: "currSleep")
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        defaults.set(counterView.counter, forKey: "currSleep")
    }
}
