//
//  CalendarViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 10/28/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import CareKit

import Firebase

class CalendarViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var hydGoal: UILabel!
    
    lazy var carePlanStore: OCKCarePlanStore = {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("carePlanStore")
        
        if !fileManager.fileExists(atPath: url.path) {
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return OCKCarePlanStore(persistenceDirectoryURL: url)
    }()
   
    @IBOutlet weak var label: UILabel!
    
//    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var logButton: UIButton!

    let today = Date()
    let calendar = Calendar.current

  
    let formatter = DateFormatter()
    let secFormatter = DateFormatter()
//
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let careCard = OCKCareCardViewController(carePlanStore: carePlanStore)
        careCard.title = "Care"
        careCard.glyphType = .heart
        careCard.glyphTintColor = .red
        careCard.tabBarItem.image = UIImage(named: "prog")
        
        showDetailViewController(careCard, sender: self)
        let maxDayIndex = stackView.arrangedSubviews.count - 1
       secFormatter.dateFormat = "EEEE"
       logButton.setTitle("Log your \(secFormatter.string(from: today)) progress", for: UIControlState.normal)


       let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"

//        4 - setup date formatter and calendar
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
//
//       //  5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }

        guard let username = Auth.auth().currentUser?.displayName else { return }
        label.text = "Hello \(username)"

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

}
