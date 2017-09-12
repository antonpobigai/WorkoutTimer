//
//  TimerViewController.swift
//  WorkoutTimer
//
//  Created by Anton Pobigai on 05.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //startTimeText.delegate = self
        // Do any additional setup after loading the view.
        clockLabel.text = String(format: "%02d:%02d", startMin, startSec)
        seconds = startSec
        minutes = startMin
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
    var startSec = 0
    var startMin = 1
    var minutes = 1
    var seconds = 0
    
    var isStarted = false

    @IBOutlet weak var clockLabel: UILabel!
    
    /*var clockTime : [String] {
        get {
            let a = clockLabel.text!
            let arr = a.components(separatedBy: ":")
            return arr
        }
        set {
            clockLabel.text = String(format: "%02d:%02d", newValue[0], newValue[1])
        }
    }
    
    func doneButtonPressed() {
            seconds = startSec
            minutes = startMin
            let arr = ["\(minutes)", "\(seconds)"]
            print(arr)
            clockTime = arr
    }*/
    
    
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButton(_ sender: UIButton) {
        if isStarted == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StopwatchViewController.action), userInfo: nil, repeats: true)
            
            sender.setTitle("Pause", for: .normal)
            isStarted = true
            clockLabel.text = String(format: "%02d:%02d", minutes, seconds)

        }
        else {
            timer.invalidate()
            sender.setTitle("Start", for: .normal)
            isStarted = false
        }
    }
    @IBAction func reserButtonPressed(_ sender: UIButton) {
        seconds = startSec
        minutes = startMin
        timer.invalidate()
        
        clockLabel.text = String(format: "%02d:%02d", startMin, startSec)
        startButton.setTitle("Start", for: .normal)
        isStarted = false
    }
    func action() {
        seconds -= 1
        if (seconds <= 0) {
            minutes -= 1
            seconds = 59
        }
        clockLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC :TimerSettingsVC = segue.destination as! TimerSettingsVC
        destionationVC.txtSec = String(startSec)
        destionationVC.txtMin = String(startMin)
        //destionationVC.txtLoad = String()
    }

}
