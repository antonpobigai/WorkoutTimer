//
//  TimerSettingsVC.swift
//  WorkoutTimer
//
//  Created by admin on 10.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

protocol ValueReturner {
    var returnValueToCaller: ((Any) -> ())?  { get set }
}

class TimerSettingsVC: UIViewController, ValueReturner {
    var returnValueToCaller: ((Any) -> ())?
    
    @IBOutlet weak var minWorkText: UITextField!
    var minWork :Int = 0

    @IBOutlet weak var secWorkText: UITextField!
    var secWork :Double = 0

    @IBOutlet weak var loadTextEdit: UITextField!
    var load :Int = 0

    @IBOutlet weak var minRestText: UITextField!
    var minRest :Int = 0
    
    @IBOutlet weak var secRestText: UITextField!
    var secRest :Double = 0
    
    @IBOutlet weak var roundsText: UITextField!
    var rounds :Int = 0
    
    func intForm(_ string: String?) -> Int {
        if let txt = string {
            return Int(txt)!
        }
        return 0
    }
    func doubleForm(_ string: String?) -> Double {
        if let txt = string {
            return Double(txt)!
        }
        return 0
    }
    @IBAction func donePressed(_ sender: UIButton) {
        let turple :(Int,Double, Int, Double, Int, Int) =
            (intForm(minWorkText.text),
             doubleForm(secWorkText.text),
             intForm(minRestText.text),
             doubleForm(secRestText.text),
             intForm(loadTextEdit.text),
             intForm(roundsText.text))
        returnValueToCaller?(turple)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //minWorkText.text = String(minWork)
        minWorkText.text = formatter.string(from: NSNumber(value: minWork))
        secWorkText.text = formatter.string(from: NSNumber(value: secWork))
        minRestText.text = formatter.string(from: NSNumber(value: minRest))
        secRestText.text = formatter.string(from: NSNumber(value: secRest))
        loadTextEdit.text = formatter.string(from: NSNumber(value: load))
        roundsText.text = formatter.string(from: NSNumber(value: rounds))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
