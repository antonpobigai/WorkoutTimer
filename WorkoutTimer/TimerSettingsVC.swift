//
//  TimerSettingsVC.swift
//  WorkoutTimer
//
//  Created by admin on 10.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class TimerSettingsVC: UIViewController {
    @IBOutlet weak var minTextEdit: UITextField!
    var txtMin: String = ""
    
    @IBOutlet weak var secTextEdit: UITextField!
    var txtSec: String = ""
    
    @IBOutlet weak var loadTextEdit: UITextField!
    var txtLoad: String = ""
    
    @IBAction func donePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        minTextEdit.text = txtMin
        secTextEdit.text = txtSec
        loadTextEdit.text = txtLoad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC :TimerViewController = segue.destination as! TimerViewController
        
        destionationVC.startSec = Int(secTextEdit.text!)!
        destionationVC.startMin = Int(minTextEdit.text!)!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
