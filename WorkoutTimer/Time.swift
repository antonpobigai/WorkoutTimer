//
//  Time.swift
//  TestTimer
//
//  Created by admin on 17.09.17.
//  Copyright © 2017 Ivan Bolgov. All rights reserved.
//
import UIKit
import AVFoundation

class Time {
    
    private var timer = Timer()
    init() {
        self.startM = 0
        self.startS = 0
        isStopWatch = true
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
        isRest = false
        isStopWatch = false
        roundsLabel?.text = String(format: "%d / %d", nowRound, self.rounds!)
    }
    var label :UILabel?
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
    private var isRest :Bool?
    private var isStopWatch :Bool
    private var player:AVAudioPlayer?
    
    private var playerOnce: AVAudioPlayer?
    
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
    var curentStopWatchTime : (Int, Double){
        get {
            let arr = label?.text!.components(separatedBy: ":")
            return (Int(arr![0])!, Double(arr![1])!)
        }
        set {
            label!.text = String(format: "%02d:%05.2f", newValue.0, newValue.1)
        }
    }
    var audioSet : (String, String) {
        get {
            if player != nil {
                let url = player?.url?.absoluteString
                print(url!)
                return ("w", "2")
            }
            return ("1", "1")
        }
        set {
            do {
                let audioPath = Bundle.main.path(forResource: newValue.0, ofType: newValue.1)
                try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
                player?.numberOfLoops = -1
            }
            catch {
                //ERROR
            }
        }
    }
    var audioSetOnce : (String, String) {
        get {
            if playerOnce != nil {
                let url = playerOnce?.url?.absoluteString
                print(url!)
                return ("w", "2")
            }
            return ("1", "1")
        }
        set {
            do {
                let audioPath = Bundle.main.path(forResource: newValue.0, ofType: newValue.1)
                try playerOnce = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
                playerOnce?.numberOfLoops = 0
            }
            catch {
                //ERROR
            }
        }
    }
    func send(lbl: UILabel, restLabel: UILabel?, loading: UILabel?, roundsLabel: UILabel?) {
        label = lbl
        self.restLabel = restLabel
        self.loading = loading
        self.roundsLabel = roundsLabel
    }
    func start(interval: Double, selector:Selector) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: selector, userInfo: nil, repeats: true)
        audioSet = ("work", "wav")
    }
    
    func reset() {
        timer.invalidate()
        if let audio = player {
            audio.stop()
        }
        s = startS
        m = startM
        if !isStopWatch {
            curentWorkTime = (m, s)
        }
        else {
            curentStopWatchTime = (m, s)
        }
        if let rM = restM, let rS = restS {
            curentRestTime = (rM, rS)
        }
        if isRest != nil {
            isRest = false
        }
        nowLoad = load
        nowRound = 1
        if let curRounds = rounds {
            roundsLabel?.text = String(format: "%d / %d", nowRound, curRounds)
        }
    }
    func pause() {
        timer.invalidate()
        player?.pause()
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
        player?.prepareToPlay()
        player?.play()
        loading?.text = " "
        let point = (m,s)
        switch point {
        case (0, 0):
            if isRest == false {
                goForTheRest()
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
                goForTheWork()
                curentWorkTime = (startM, startS)
                curentRestTime = (restM!, restS!)
            }
        case let (x,0) where x != 0:
            prevMinute()
            
        default:
            s -= 1
        }
        if !isRest! {
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
        curentStopWatchTime = (m, s)
    }
    private func goForTheRest() {
        m = restM!
        s = restS!
        audioSetOnce = ("complete", "wav")
        playerOnce?.play()
    }
    private func goForTheWork() {
        m = startM
        s = startS
        audioSetOnce = ("complete", "wav")
        playerOnce?.play()
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
        self.reset()
        audioSetOnce = ("end", "wav")
        playerOnce?.play()
        
    }
    func reload(min: Int, sec:Double, mRest:Int, sRest:Double, load:Int, rounds:Int) {
        self.reset()
        startM = min
        startS = sec
        restM = mRest
        restS = sRest
        self.load = load
        self.rounds = rounds
        self.reset()
    }
    var getStartMins :Int {
        return startM
    }
    var getStartSecs :Double {
        return startS
    }
    var getRestMins :Int {
        return restM!
    }
    var getRestSecs :Double {
        return restS!
    }
    var getLoad :Int {
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
