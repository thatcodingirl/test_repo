//
//  drinkViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/29/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit

class drinkViewController: UIViewController {

    let defaults = UserDefaults.standard

    let date = Date()
    
    var totalPercent = Float(0)
    @IBOutlet weak var mainPerLabel: UILabel!
    let shapeLayer = CAShapeLayer()
    
    @IBOutlet weak var outputLabel: UILabel!
 
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var lessButton: PushButton!
    @IBOutlet weak var moreButton: PushButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPerLabel.center = CGPoint(x: CGFloat(185), y: CGFloat(300))
        let val = defaults.integer(forKey: "hydrationGoal")
        let totalCurrent = 0
        let totalGoal = defaults.integer(forKey: "hydrationGoal")
        outputLabel.text = "\(val) cups of \r\n water"
        totalPercent = Float(totalCurrent)/Float(totalGoal)
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 90, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position =  CGPoint(x: CGFloat(185), y: CGFloat(300))
        view.layer.addSublayer(trackLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position =  CGPoint(x: CGFloat(185), y: CGFloat(300))
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
      //  counterLabel.text = defaults.string(forKey: "currDrink")
      //  counterView.counter = defaults.integer(forKey: "currDrink")
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
        defaults.set(counterView.counter, forKey: "currDrink")
    }


}
