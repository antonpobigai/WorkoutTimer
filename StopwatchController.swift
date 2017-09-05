//
//  Stopwatch.swift
//  WorkoutTimer
//
//  Created by admin on 04.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class StopwatchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.alpha = 0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var modalView: UIView!
    @IBAction func invoke(_ sender: UIButton) {
        modalView.alpha = 1
    }
    
}

