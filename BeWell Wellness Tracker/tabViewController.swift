//
//  tabViewController.swift
//  BeWell Wellness Tracker
//
//  Created by Jesica Quinones on 12/10/18.
//  Copyright © 2018 Jesica Quinones. All rights reserved.
//

import UIKit
import CareKit

class tabViewController: UITabBarController {
//

        let defaults = UserDefaults.standard
        lazy var carePlanStore: OCKCarePlanStore = {
            let fileManager = FileManager.default
            let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let url = urls[0].appendingPathComponent("carePlanStore")
    
            if !fileManager.fileExists(atPath: url.path) {
                try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
    
            return OCKCarePlanStore(persistenceDirectoryURL: url)
        }()



        let activityStartDate = DateComponents(year: 2016, month: 1, day: 1)

        func addActivities() {
            carePlanStore.activities { [unowned self] (_, activities, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard activities.count == 0 else { return }
    
                for activity in self.interventions() + self.assessments() {
                    self.carePlanStore.add(activity) { (_, error) in
                        guard let error = error else { return }
                        print(error.localizedDescription)
                    }
                }
            }
        }

        func interventions() -> [OCKCarePlanActivity] {
            let waterSchedule = OCKCareSchedule.dailySchedule(withStartDate: activityStartDate, occurrencesPerDay: 8)
            let waterIntervention = OCKCarePlanActivity.intervention(withIdentifier: "water", groupIdentifier: nil, title: "Water", text: "Number of glasses", tintColor: .blue, instructions: "Hydration is key for optimal health! Doctors recommend drinking at least 8 glasses of water a day. Use this tool to increase your water intake and improve your daily hydration.", imageURL: nil, schedule: waterSchedule, userInfo: nil, optional: true)
    
            let exerciseSchedule = OCKCareSchedule.dailySchedule(withStartDate: activityStartDate, occurrencesPerDay: 2)
            let exerciseIntervention = OCKCarePlanActivity.intervention(withIdentifier: "exercise", groupIdentifier: nil, title: "Exercise", text: "hours", tintColor: .orange, instructions: "Staying active is a very important aspect of your health journey. It is recommended to have at least 30 minutes to an hour of physical activity a day. Use this tool to increase and track your activity daily.", imageURL: nil, schedule: exerciseSchedule, userInfo: nil, optional: true)
            return [waterIntervention, exerciseIntervention]
        }

        func assessments() -> [OCKCarePlanActivity] {
            let oncePerDaySchedule = OCKCareSchedule.dailySchedule(withStartDate: activityStartDate, occurrencesPerDay: 1)
    
            let sleepAssessment = OCKCarePlanActivity.assessment(withIdentifier: "sleep", groupIdentifier: nil, title: "Sleep", text: "How many hours did you sleep last night?", tintColor: .purple, resultResettable: true, schedule: oncePerDaySchedule, userInfo: nil, optional: true)
            //let weightAssessment = OCKCarePlanActivity.assessment(withIdentifier: "weight", groupIdentifier: nil, title: "Weight", text: "How much do you weigh?", tintColor: .brown, resultResettable: true, schedule: oncePerDaySchedule, userInfo: nil, optional: true)
    
            return [sleepAssessment]
        }



        override func viewDidLoad() {
    
           addActivities()
           super.viewDidLoad()
           let careCard = OCKCareCardViewController(carePlanStore: carePlanStore)
             careCard.title = "Care"
            careCard.glyphType = .heart
            careCard.glyphTintColor = .red
            careCard.tabBarItem.image = UIImage(named: "prog")
    
    
            let symptomTracker = OCKSymptomTrackerViewController(carePlanStore: carePlanStore)
            symptomTracker.title = "Measurements"
            symptomTracker.delegate = self as! OCKSymptomTrackerViewControllerDelegate
            symptomTracker.tabBarItem.image = UIImage(named: "book")
     
    
            viewControllers?.append(contentsOf: [
                UINavigationController(rootViewController: careCard),
                UINavigationController(rootViewController: symptomTracker)
                ])
    
    
            
        }
    }


    extension tabViewController: OCKSymptomTrackerViewControllerDelegate {
    
        func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController, didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
            let alert: UIAlertController
    
            if assessmentEvent.activity.identifier == "sleep" {
                alert = sleepAlert(event: assessmentEvent)
            } else {
                return
            }
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
    
            present(alert, animated: true, completion: nil)
        }
    
        func sleepAlert(event: OCKCarePlanEvent) -> UIAlertController {
            let alert = UIAlertController(title: "Sleep", message: "How many hours did you sleep last night?", preferredStyle: .alert)
    
            alert.addTextField { textField in
                textField.keyboardType = .numberPad
            }
    
            let doneAction = UIAlertAction(title: "Done", style: .default) { [unowned self] _ in
                let sleepField = alert.textFields![0]
                let result = OCKCarePlanEventResult(valueString: sleepField.text!, unitString: "hours", userInfo: nil)
                self.carePlanStore.update(event, with: result, state: .completed) { (_, _, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            alert.addAction(doneAction)
    
            return alert
        }
    
}

