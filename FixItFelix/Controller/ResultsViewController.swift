//
//  ResultsViewController.swift
//  BMI Calculator
//
//  Created by Prince Alvin Yusuf on 19/04/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // Variable
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    // Outlet
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    // Button
    
    // Dismis is method from apple that works for ending / finishing activity process
    // or destroy an activity
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = color
    }
    

}
