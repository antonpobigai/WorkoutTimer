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
        timer.send(lbl: clockLabel, restLabel: nil, loading: nil, roundsLabel: nil)
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
    
    var timer = Time()
    //var seconds = 0.0
    //var minutes = 0
    //var miliseconds = 0
    var isStarted = false
    
    @IBOutlet weak var clockLabel: UILabel!

    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButton(_ sender: UIButton) {
        if isStarted == false {

            timer.start(interval: 0.01, selector: #selector(Time.stopWatchAction))
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            isStarted = true
        }
        else {
            timer.pause()
            sender.setImage(#imageLiteral(resourceName: "start"), for: .normal)
            isStarted = false
        }
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timer.reset()
        startButton.setImage(#imageLiteral(resourceName: "start"), for: .normal)
        isStarted = false
    }
}
