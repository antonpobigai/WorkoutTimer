//
//  TimerSettingsController.swift
//  WorkoutTimer
//
//  Created by admin on 11.10.2017.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class TimerSettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ValueReturner  {
    var returnValueToCaller: ((Any) -> ())?
    
    @IBOutlet weak var pickerWork: UIPickerView!
    @IBOutlet weak var pickerRest: UIPickerView!
    @IBOutlet weak var pickerParam: UIPickerView!
    
    var workMin = 0
    var workSec = 0
    var restMin = 0
    var restSec = 0
    var rounds = 1
    var load = 0
    var pickerData = [[String]]()
    var dataParam = [[String]]()
    @IBAction func donePressed(_ sender: UIButton) {
        let turple :(Int,Double, Int, Double, Int, Int) =
            (workMin, Double(workSec), restMin, Double(restSec), load, rounds)
        returnValueToCaller?(turple)
        print(turple)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func numberOfComponents(in picker: UIPickerView) -> Int {
        if picker.tag == 3 {
            return dataParam.count
        }
        return pickerData.count
    }
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component :Int) -> Int {
        if picker.tag == 3 {
            return dataParam[component].count
        }
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var titleData: String!
        if pickerView.tag == 3 {
            titleData = dataParam[component][row].description
        }
        else {
            titleData = pickerData[component][row].description
        }
        pickerLabel.textAlignment = .center
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 25),NSAttributedStringKey.foregroundColor:
            UIColor.black])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        updateLabel()
    }
    
    func updateLabel(){
        workMin = Int(pickerData[0][pickerWork.selectedRow(inComponent: 0)])!
        workSec = Int(pickerData[1][pickerWork.selectedRow(inComponent: 1)])!
        restMin = Int(pickerData[0][pickerRest.selectedRow(inComponent: 0)])!
        restSec = Int(pickerData[1][pickerRest.selectedRow(inComponent: 1)])!
        rounds = Int(dataParam[0][pickerParam.selectedRow(inComponent: 0)])!
        load = Int(dataParam[1][pickerParam.selectedRow(inComponent: 1)])!
    }
    func addMins() {
        pickerData.append([])
        pickerData.append([])
        for i in 0...60 {
            pickerData[0].append(String(i))
            pickerData[1].append(String(i))
        }
        dataParam.append([])
        dataParam.append([])
        for i in 0...31 {
            if i == 0 {
                dataParam[1].append(String(i))
                continue
            }
            dataParam[0].append(String(i))
            dataParam[1].append(String(i))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        addMins()
    }
    override func viewWillAppear(_ animated: Bool) {
        pickerWork.selectRow(workMin, inComponent: 0, animated: true)
        pickerWork.selectRow(workSec, inComponent: 1, animated: true)
        
        pickerRest.selectRow(restMin, inComponent: 0, animated: true)
        pickerRest.selectRow(restSec, inComponent: 1, animated: true)
        
        pickerParam.selectRow(rounds-1, inComponent: 0, animated: true)
        pickerParam.selectRow(load, inComponent: 1, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension TimerSettingsController {
    func setDelegates() {
        pickerWork.delegate = self
        pickerWork.dataSource = self
        pickerRest.delegate = self
        pickerRest.dataSource = self
        pickerParam.delegate = self
        pickerParam.dataSource = self
    }
}
