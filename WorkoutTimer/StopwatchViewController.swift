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
                self.titleLabel.text = textField.text
            }
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    var timer = Timer()
    var seconds = 0
    var minutes = 0
    var isStarted = false
    @IBOutlet weak var clockLabel: UILabel!

    @IBAction func startButton(_ sender: UIButton) {
        if isStarted == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StopwatchViewController.action), userInfo: nil, repeats: true)
            if let img = UIImage(named: "clock-timer-7") {
                sender.setImage(img, for: .normal)
            }
            isStarted = true
            //problem with git
        }
        else {
            timer.invalidate()
            seconds = 0
            clockLabel.text = "00:00"
            if let img = UIImage(named: "clock") {
                sender.setImage(img, for: .normal)
            }
            isStarted = false
        }
    }
    func action() {
        seconds += 1
        if (seconds >= 60) {
            minutes += 1
            seconds = 0
        }
        clockLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
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
