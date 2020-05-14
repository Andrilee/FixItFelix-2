//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // Variable
var calculatorBrain = CalculatorBrain()
    // Outlet
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var highSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    // Button
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let formatted = String(format: "%.2f", sender.value)
        print(formatted)
        
        heightLabel.text = formatted + "m"
    }
    
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let formatted = Int(sender.value)
        print(formatted)
        
        weightLabel.text = String(formatted) + "Kg"
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = highSlider.value
        let weight = weightSlider.value
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    // This method is called when the apps launch for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // This method is for change the activity from one to destination
    // Important: segue.destination is (UIViewController)
    // Use as! for give the information to destinationVC that ResultsViewController
    // is the type of data you want to access
    // destinationVC.bmiValue means = data from this activity will be transfering to
    // destination activity
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
            
        }
    }
    
    
}

