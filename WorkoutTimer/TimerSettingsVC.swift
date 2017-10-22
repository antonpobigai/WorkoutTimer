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

class TimerSettingsVC: UIViewController, UITextFieldDelegate, ValueReturner {
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
    
    
    
    func isZeroCount(of string:String) -> Bool {
        if string.characters.count == 0 {
            return true
        }
        return false
    }
    func intForm(_ string: String?) -> Int {
        if let txt = string {
            return isZeroCount(of: txt) ? 0 : Int(txt)!
        }
        return 0
    }
    func doubleForm(_ string: String?) -> Double {
        if let txt = string {
            return isZeroCount(of: txt) ? 0: Double(txt)!
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        var newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        let char = string.cString(using: String.Encoding.utf8)
        let backspace = strcmp(char, "\\b")
        if newString.length == 0 {
            newString = "0"
        }
        return newString.length <= maxLength && maxValue(of :newString) || isBackSpace(backspace)
    }
    func isBackSpace(_ backSpace: Int32) -> Bool {
        return backSpace == -92 ? true : false
    }
    func maxValue(of newText :NSString) -> Bool {
        let string = newText as String
        if let str = Int(string) {
            if str < 60 {
                return true
            }
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*minWorkText.delegate = self
        secWorkText.delegate = self
        minRestText.delegate = self
        secRestText.delegate = self
        loadTextEdit.delegate = self
        roundsText.delegate = self
        minWorkText.text = formatter.string(from: NSNumber(value: minWork))
        secWorkText.text = formatter.string(from: NSNumber(value: secWork))
        minRestText.text = formatter.string(from: NSNumber(value: minRest))
        secRestText.text = formatter.string(from: NSNumber(value: secRest))
        loadTextEdit.text = formatter.string(from: NSNumber(value: load))
        roundsText.text = formatter.string(from: NSNumber(value: rounds))*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
