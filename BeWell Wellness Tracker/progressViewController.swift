//
//  progressViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 12/10/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import Firebase

class progressViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hydGoal: UILabel!
    @IBOutlet weak var sleepGoal: UILabel!
    @IBOutlet weak var exerciseGoal: UILabel!
    
    
    //    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var graphView: GraphView!
    
    
    let today = Date()
    let calendar = Calendar.current
    
    
    let formatter = DateFormatter()
    let secFormatter = DateFormatter()
    //
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup view did load here
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        secFormatter.dateFormat = "EEEE"
        
        
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        // 4 - setup date formatter and calendar
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        //
        //  5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
        
        let cups = defaults.integer(forKey: "hydrationGoal")
        let wo = defaults.integer(forKey: "exerciseGoal")
        let sleep = defaults.integer(forKey: "sleepGoal")
        
        if(!(cups == 0 || wo == 0 || sleep == 0 )){
            print(cups)
            print(wo)
            print(sleep)
            hydGoal.text = "\(cups) cups of water"
            sleepGoal.text = "\(sleep) hours of sleep"
            exerciseGoal.text = "\(wo) hours of exercise"
            
            guard let username = Auth.auth().currentUser?.displayName else { return }
            label.text = "Hello \(username)"
            
            //  Do any additional setup after loading the view.
        }
        
        
        
        
    }
    
    
}
