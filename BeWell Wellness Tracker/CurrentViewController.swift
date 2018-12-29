//
//  CurrentViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/28/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import Firebase

class CurrentViewController: UIViewController {

    let defaults = UserDefaults.standard
    var waterPercent = Float(0)
    var totalPercent = Float(0)
    var nutritionPercent = Float(0)
    var sleepPercent = Float(0)
    
    @IBOutlet weak var hydLabel: UILabel!
    @IBOutlet weak var nutLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    
    @IBOutlet weak var mainPerLabel: UILabel!
    @IBOutlet weak var hydPerLabel: UILabel!
    @IBOutlet weak var nutPerLabel: UILabel!
    @IBOutlet weak var sleepPerLabel: UILabel!
    
    @IBOutlet weak var hydButton: UIButton!
    @IBOutlet weak var nutButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
     let shapeLayer = CAShapeLayer()
     let firstShapeLayer = CAShapeLayer()
     let secondShapeLayer = CAShapeLayer()
     let thirdShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        hydLabel.center = CGPoint(x: CGFloat(75), y: CGFloat(620))
        nutLabel.center = CGPoint(x: CGFloat(185), y: CGFloat(620))
        sleepLabel.center = CGPoint(x: CGFloat(295), y: CGFloat(620))
        mainPerLabel.center = CGPoint(x: CGFloat(185), y: CGFloat(300))
        hydPerLabel.center = CGPoint(x: CGFloat(75), y: CGFloat(550))
        nutPerLabel.center = CGPoint(x: CGFloat(185), y: CGFloat(550))
        sleepPerLabel.center = CGPoint(x: CGFloat(295), y: CGFloat(550))
       
        
        let waterGoal = defaults.integer(forKey: "hydrationGoal")
        let nutritionGoal = defaults.integer(forKey: "nutritionGoal")
        let sleepGoal = defaults.integer(forKey: "sleepGoal")

        let waterCurrent = defaults.integer(forKey: "currDrink")
        let nutritionCurrent = defaults.integer(forKey: "currFood")
        let sleepCurrent = defaults.integer(forKey: "currSleep")
        
        let totalCurrent = waterCurrent + (nutritionCurrent/100) + sleepCurrent
        let totalGoal = waterGoal + (nutritionGoal/100) + sleepGoal
        
        waterPercent = Float(waterCurrent)/Float(waterGoal)
        totalPercent = Float(totalCurrent)/Float(totalGoal)
        nutritionPercent = Float(nutritionCurrent)/Float(nutritionGoal)
        sleepPercent = Float(sleepCurrent)/Float(sleepGoal)
        
        
        // Do any additional setup after loading the view.
    
        //create my main track layer
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
        
        //create first bottom track layer (drink)
        let firstTrackLayer = CAShapeLayer()
        let firstCircularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        firstTrackLayer.path = firstCircularPath.cgPath
        firstTrackLayer.strokeColor = UIColor.lightGray.cgColor
        firstTrackLayer.fillColor = UIColor.clear.cgColor
        firstTrackLayer.lineWidth = 10
        firstTrackLayer.lineCap = kCALineCapRound
        firstTrackLayer.position =  CGPoint(x: CGFloat(75), y: CGFloat(550))
        view.layer.addSublayer(firstTrackLayer)
        
        
        firstShapeLayer.path = firstCircularPath.cgPath
        firstShapeLayer.strokeColor = UIColor.cyan.cgColor
        firstShapeLayer.fillColor = UIColor.clear.cgColor
        firstShapeLayer.lineWidth = 10
        firstShapeLayer.lineCap = kCALineCapRound
        firstShapeLayer.position =  CGPoint(x: CGFloat(75), y: CGFloat(550))
        
        firstShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        firstShapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(firstShapeLayer)
        
        
        //create second bottom track layer (food)
        let secondTrackLayer = CAShapeLayer()
        let secondCircularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        secondTrackLayer.path = secondCircularPath.cgPath
        secondTrackLayer.strokeColor = UIColor.lightGray.cgColor
        secondTrackLayer.fillColor = UIColor.clear.cgColor
        secondTrackLayer.lineWidth = 10
        secondTrackLayer.lineCap = kCALineCapRound
        secondTrackLayer.position =  CGPoint(x: CGFloat(185), y: CGFloat(550))
        view.layer.addSublayer(secondTrackLayer)
        
        
        secondShapeLayer.path = secondCircularPath.cgPath
        secondShapeLayer.strokeColor = UIColor.purple.cgColor
        secondShapeLayer.fillColor = UIColor.clear.cgColor
        secondShapeLayer.lineWidth = 10
        secondShapeLayer.position =  CGPoint(x: CGFloat(185), y: CGFloat(550))
        secondShapeLayer.lineCap = kCALineCapRound
        secondShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        secondShapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(secondShapeLayer)
        
        //create third bottom track layer (sleep)
        let thirdTrackLayer = CAShapeLayer()
        let thirdCircularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        thirdTrackLayer.path = thirdCircularPath.cgPath
        thirdTrackLayer.strokeColor = UIColor.lightGray.cgColor
        thirdTrackLayer.fillColor = UIColor.clear.cgColor
        thirdTrackLayer.lineWidth = 10
        thirdTrackLayer.lineCap = kCALineCapRound
        thirdTrackLayer.position =  CGPoint(x: CGFloat(295), y: CGFloat(550))
        view.layer.addSublayer(thirdTrackLayer)
        
        
        thirdShapeLayer.path = thirdCircularPath.cgPath
        thirdShapeLayer.strokeColor = UIColor.magenta.cgColor
        thirdShapeLayer.fillColor = UIColor.clear.cgColor
        thirdShapeLayer.lineWidth = 10
        thirdShapeLayer.position = CGPoint(x: CGFloat(295), y: CGFloat(550))
        thirdShapeLayer.lineCap = kCALineCapRound
        thirdShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        thirdShapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(thirdShapeLayer)
        
        
        
        //end of viewdidload
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
       
    }
   
    @objc public func handleTap() {
        print("Attempting to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
       
        
        shapeLayer.speed = 0.2
        shapeLayer.strokeEnd = CGFloat(totalPercent)
        mainPerLabel.text = "\(Int(totalPercent*100))%"
        
        firstShapeLayer.speed = 0.2
        firstShapeLayer.strokeEnd = CGFloat(waterPercent)
        hydPerLabel.text = "\(Int(waterPercent*100))%"
        
        secondShapeLayer.speed = 0.2
        secondShapeLayer.strokeEnd = CGFloat(nutritionPercent)
        nutPerLabel.text = "\(Int(nutritionPercent*100))%"
        
        thirdShapeLayer.speed = 0.2
        thirdShapeLayer.strokeEnd = CGFloat(sleepPercent)
        sleepPerLabel.text = "\(Int(sleepPercent*100))%"
        
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

}
