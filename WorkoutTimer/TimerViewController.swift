//
//  TimerViewController.swift
//  WorkoutTimer
//
//  Created by Anton Pobigai on 05.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//
import UIKit
import AVFoundation

class TimerViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clockLabel.text = String(format: "%02d:%02.0f", timer.startM, timer.startS)
        restLabel.text = String(format: "%02d:%02.0f", timer.getRestMins, timer.getRestSecs)
        roundsLabel!.text = "1 / \(timer.getRounds)"
        timer.send(lbl: clockLabel, restLabel: restLabel, loading: loading, roundsLabel: roundsLabel)
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
                    if (textField.text?.characters.count)! < 15 {
                        self.titleLabel.text = textField.text
                    }
                }
            }
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    var isStarted = false
    var timer: Time = Time(min: 0, sec: 30, minsForRest: 0, secsForRest: 30, secsForLoad: 0, rounds: 5)

    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var loading: UILabel!
    
    @IBOutlet weak var roundsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButton(_ sender: UIButton) {
        if isStarted == false {
            timer.start(interval: 1, selector: #selector(Time.action))
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            isStarted = true
        }
        else {
            timer.pause()
            if #imageLiteral(resourceName: "start") as UIImage? != nil {
                sender.setImage(#imageLiteral(resourceName: "start"), for: .normal)
            }
            else {
                sender.setTitle("Play", for: .normal)
            }
            isStarted = false
        }
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timer.reset()
        startButton.setImage(#imageLiteral(resourceName: "start"), for: .normal)
        isStarted = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC :TimerSettingsController = segue.destination as! TimerSettingsController
        destionationVC.workSec = Int(timer.getStartSecs)
        destionationVC.workMin = timer.getStartMins
        destionationVC.restSec = Int(timer.getRestSecs)
        destionationVC.restMin = timer.getRestMins
        destionationVC.load = timer.getLoad
        destionationVC.rounds = timer.getRounds
 
        var secondViewController = segue.destination as? ValueReturner
        secondViewController?.returnValueToCaller = someFunctionThatWillHandleYourReturnValue
    }
    func someFunctionThatWillHandleYourReturnValue(returnedValue1: Any) {
        if let arr = returnedValue1 as? (Int,Double, Int, Double, Int, Int) {
            timer.reload(min: arr.0, sec: arr.1, mRest: arr.2, sRest: arr.3, load: arr.4, rounds: arr.5)

            startButton.setBackgroundImage(#imageLiteral(resourceName: "start"), for: .normal)
        }
        clockLabel.text = String(format: "%02d:%02.0f", timer.getStartMins, timer.getStartSecs)
    }
}
