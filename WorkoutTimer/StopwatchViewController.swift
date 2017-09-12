//
//  StopwatchViewController.swift
//  WorkoutTimer
//
//  Created by Anton Pobigai on 05.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter your title",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "type here"
            textField.clearButtonMode = .whileEditing
            textField.autocapitalizationType = .sentences
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            if textField.text != "" {
                if textField.text!.characters.count < 30 {
                    self.titleLabel.text = textField.text
                }
            }
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    
    var timer = Timer()
    var seconds = 0
    var minutes = 0
    var miliseconds = 0
    var isStarted = false
    
    @IBOutlet weak var clockLabel: UILabel!

    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButton(_ sender: UIButton) {
        if isStarted == false {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(StopwatchViewController.action), userInfo: nil, repeats: true)
           
            sender.setTitle("Pause", for: .normal)
            isStarted = true
        }
        else {
            timer.invalidate()
            sender.setTitle("Start", for: .normal)
            isStarted = false
        }
    }
    @IBAction func reserButtonPressed(_ sender: UIButton) {
        seconds = 0
        minutes = 0
        timer.invalidate()
        
        clockLabel.text = "00:00.00"
        startButton.setTitle("Start", for: .normal)
        isStarted = false
    }
    func action() {
        miliseconds += 1
        if (miliseconds >= 60) {
            seconds += 1
            miliseconds = 0
        }
        if (seconds >= 60) {
            minutes += 1
            seconds = 0
        }
        clockLabel.text = String(format: "%02d:%02d.%02d", minutes, seconds, miliseconds)
    }

}
