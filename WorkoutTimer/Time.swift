//
//  Time.swift
//  TestTimer
//
//  Created by admin on 17.09.17.
//  Copyright © 2017 Ivan Bolgov. All rights reserved.
//
import UIKit

class Time {
    
    private var timer = Timer()
    init() {
        self.startM = 0
        self.startS = 0
    }
    init(min: Int, sec: Double) {
        self.startM = min
        self.startS = sec
        self.restM = 0
        self.restS = 0
        self.load = 0
        nowLoad = load
        self.rounds = 0
        roundsLabel?.text = String(format: "%02d / %02d", nowRound, rounds!)
    }
    init(min: Int, sec: Double, minsForRest: Int?, secsForRest: Double) {
        self.startM = min
        self.startS = sec
        self.restM = minsForRest
        self.restS = secsForRest
        self.load = 0
        nowLoad = load
        self.rounds = 0
        roundsLabel?.text = String(format: "%02d / %02d", nowRound, rounds!)
    }
    init(min: Int, sec: Double, minsForRest: Int?, secsForRest: Double, secsForLoad: Int) {
        self.startM = min
        m = startM
        self.startS = sec
        s = startS
        self.restM = minsForRest
        self.restS = secsForRest
        self.load = secsForLoad
        nowLoad = load
        self.rounds = 0
        roundsLabel?.text = String(format: "%d / %d", nowRound, rounds!)
    }
    init(min: Int, sec: Double, minsForRest: Int?, secsForRest: Double, secsForLoad: Int, rounds:Int) {
        self.startM = min
        m = startM
        self.startS = sec
        s = startS
        self.restM = minsForRest
        self.restS = secsForRest
        self.load = secsForLoad
        nowLoad = load
        self.rounds = rounds
        roundsLabel?.text = String(format: "%d / %d", nowRound, self.rounds!)
    }
    var label :UILabel?
    var state :UILabel?
    var restLabel :UILabel?
    private var loading :UILabel?
    private var roundsLabel: UILabel?
    private var s = 0.0
    private var m = 0
    private var nowRound = 1
    var startM :Int
    var startS :Double
    private var load :Int?
    private var nowLoad :Int?
    private var rounds: Int?
    private var restM :Int?
    private var restS :Double?
    private var isRest = false
    
    var curentWorkTime : (Int, Double){
        get {
            let arr = label?.text!.components(separatedBy: ":")
            return (Int(arr![0])!, Double(arr![1])!)
        }
        set {
            label!.text = String(format: "%02d:%02.0f", newValue.0, newValue.1)
        }
    }
    var curentRestTime : (Int, Double) {
        get {
            let arr = restLabel?.text!.components(separatedBy: ":")
            return (Int(arr![0])!, Double(arr![1])!)
        }
        set {
            restLabel!.text = String(format: "%02d:%02.0f", newValue.0, newValue.1)
        }
    }
    func send(lbl: UILabel, restLabel: UILabel?, state: UILabel?, loading: UILabel?, roundsLabel: UILabel?) {
        label = lbl
        self.restLabel = restLabel
        self.state = state
        self.loading = loading
        self.roundsLabel = roundsLabel
    }
    func start(interval: Double, selector:Selector) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: selector, userInfo: nil, repeats: true)
        state?.text = isRest ? "Rest!" : "Work!"
    }
    
    func reset() {
        timer.invalidate()
        if let stateLabel = state {
            stateLabel.text = " "
        }
        s = startS
        m = startM
        curentWorkTime = (m, s)
        curentRestTime = (restM!, restS!)
        isRest = false
        nowLoad = load
        nowRound = 1
        roundsLabel?.text = String(format: "%d / %d", nowRound, rounds!)
    }
    func pause() {
        timer.invalidate()
    }
    private func display() {
        print("start min\(startM)")
        print("start sec \(startS)")
        print("rest min \(restM!)")
        print("rest sec \(restS!)")
        print("load  \(load!)")
        print("rounds \(rounds!)")
    }
    @objc func action()
    {
        while nowLoad! > 0 {
            loading?.text = "\(nowLoad!)"
            nowLoad! -= 1
            return
        }
        loading?.text = " "
        let point = (m,s)
        switch point {
        case (0, 0):
            if isRest == false {
                goForTheRest()
                state?.text = "Rest!"
                isRest = true
            }
            else {
                isRest = false
                if nowRound == rounds {
                    finish()
                    return
                }
                nowRound += 1
                roundsLabel!.text = String(format: "%d / %d", nowRound, rounds!)
                state?.text = "Work!"
                goForTheWork()
                curentWorkTime = (startM, startS)
                curentRestTime = (restM!, restS!)
            }
        case let (x,0) where x != 0:
            prevMinute()
            
        default:
            s -= 1
        }
        if !isRest {
            curentWorkTime = (m, s)
        }
        else {
            curentRestTime = (m, s)
        }
    }
    @objc func stopWatchAction() {
        s = Double(s) + 0.01
        if (s == 60) {
            m += 1
            s = 0
        }
        curentWorkTime = (m, s)
    }
    private func goForTheRest() {
        m = restM!
        s = restS!
    }
    private func goForTheWork() {
        m = startM
        s = startS
    }
    private func prevMinute() {
        m -= 1
        s = 59
    }
    private func nextMinute() {
        m += 1
        s = 0
    }
    private func finish() {
        timer.invalidate()
        state?.text = "Completed"
        
    }
    func reload(min: Int, sec:Double, mRest:Int, sRest:Double, load:Int, rounds:Int) {
        
        startM = min
        startS = sec
        restM = mRest
        restS = sRest
        self.load = load
        self.rounds = rounds
        self.reset()
        display()
    }
    func getStartMins() -> Int {
        return startM
    }
    func getStartSecs() -> Double {
        return startS
    }
    func getRestMins() -> Int {
        return restM!
    }
    func getRestSecs() -> Double {
        return restS!
    }
    func getLoad() -> Int {
        return load!
    }
    var getRounds :Int {
        return rounds!
    }
}
let formatter:NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 6
    formatter.notANumberSymbol = "Error"
    formatter.groupingSeparator = " "
    formatter.locale = Locale.current
    return formatter
    
} ()
