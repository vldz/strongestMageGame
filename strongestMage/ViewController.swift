//
//  ViewController.swift
//  strongest mage
//
//  Created by vld on 5/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import UIKit
import Darwin
import Foundation

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var topMage: UIButton!
    @IBOutlet weak var bottomMage: UIButton!

    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var readyTop: UIButton!
    
    @IBOutlet weak var raySubview: UIView!
    
    @IBOutlet weak var InfoForTopMage: UILabel!
    @IBOutlet weak var InfoForBottomMage: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var restartBottom: UIButton!
    @IBOutlet weak var restartTop: UIButton!
    
    var imageYPosition = 0.0
    
    var isReadyTop = false
    var isReadyBottom = false
    var isReadyToRestartTop = false
    var isReadyToRestartBottom = false
    
    var restartCounter = 0
    var countdownTimer: Timer!
    var totalTime = 3
    
    var clickCounter = 1
    var totalDistance = 25
    var timerCounter = -3.0
    var timer = Timer()
    var timerIsOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        view.backgroundColor = UIColor.black
        buttonTransformUpSideDown()
        
        updateTimerInfo()

        self.circle.center = CGPoint(x:raySubview.frame.width / 2, y:raySubview.frame.height / 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTransformUpSideDown() {
        topMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        InfoForTopMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        restartTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func ready(_ sender: Any) {
        isReadyBottom = true
        readyButton.setTitle("ready!", for: .normal)
        readyButton.isEnabled = false
        if isReadyBottom && isReadyTop {
            self.readyF()
        }
    }
    
    @IBAction func readyTop(_ sender: Any) {
        isReadyTop = true
        readyTop.setTitle("ready!", for: .normal)
        readyTop.isEnabled = false
        if isReadyTop && isReadyBottom {
            self.readyF()
        }
    }
    
    func readyF() {
        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
        imageYPosition = Double(self.circle.center.y)
        InfoForTopMage.isHidden = false
        InfoForBottomMage.isHidden = false
        readyButton.isHidden = true
        readyTop.isHidden = true
        startTimer()
        startStatisticsTimer()
    }
    
    @IBAction func moveToBottom(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if (self.imageYPosition < Double(self.raySubview.bounds.height)) {
                self.circle.center.y += 25
                self.clickCounter += 1
                self.totalDistance += 25
                self.imageYPosition = Double(self.circle.center.y)
                print(self.imageYPosition)
            } else {
                self.winLose(decider: 2)
                self.topMage.isEnabled = false
                self.bottomMage.isEnabled = false
                self.circle.isHidden = true
                self.restartBottom.isHidden = false
                self.restartTop.isHidden = false
                self.randomInfo()
            }
        }, completion: nil)
    }
    
    @IBAction func moveToTop(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if (self.imageYPosition > 0) {
                self.circle.center.y -= 25
                self.clickCounter += 1
                self.totalDistance += 25
                self.imageYPosition = Double(self.circle.center.y)
                print(self.imageYPosition)
            } else {
                self.winLose(decider: 1)
                self.topMage.isEnabled = false
                self.bottomMage.isEnabled = false
                self.circle.isHidden = true
                self.restartBottom.isHidden = false
                self.restartTop.isHidden = false
                self.randomInfo()
            }
        }, completion: nil)
    }
    
    @IBAction func restartBottomButton(_ sender: Any) {
        isReadyToRestartBottom = true
        self.restartBottom.setTitle("ready!", for: .normal)
        resetStatisticsTimer()
        if isReadyToRestartBottom && isReadyToRestartTop {
            self.restart()
            self.clickCounter = 1
            self.totalDistance = 25
        }
    }
    
    @IBAction func restarttopF(_ sender: Any) {
        isReadyToRestartTop = true
        self.restartTop.setTitle("ready!", for: .normal)
        resetStatisticsTimer()
        if isReadyToRestartBottom && isReadyToRestartTop {
            self.restart()
            self.clickCounter = 1
            self.totalDistance = 25
        }
    }
    
    func restart() {
        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
        imageYPosition = Double(self.circle.center.y)
        
        infoLabel.isHidden = true
        
        restartTop.isHidden = true
        restartTop.setTitle("restart?", for: .normal)
        restartBottom.isHidden = true
        restartBottom.setTitle("restart?", for: .normal)
        isReadyToRestartBottom = false
        isReadyToRestartTop = false
        
        InfoForTopMage.isHidden = false
        InfoForBottomMage.isHidden = false
        updateTimerInfo()
        startTimer()
        startStatisticsTimer()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        InfoForTopMage.isHidden = true
        InfoForBottomMage.isHidden = true
        topMage.isEnabled = true
        bottomMage.isEnabled = true
        circle.isHidden = false
        totalTime = 3
        updateTimerInfo()
    }
    
    @objc
    func updateTime() {
        totalTime -= 1
        if totalTime > 0 {
            updateTimerInfo()
        } else if totalTime == 0 {
            InfoForTopMage.text = "go!"
            InfoForBottomMage.text = "go!"
        } else {
            endTimer()
        }
    }
    
    func updateTimerInfo() {
        InfoForTopMage.text = String(totalTime)
        InfoForBottomMage.text = String(totalTime)
    }
    
    func randomInfo () {
        let randomNumber = arc4random_uniform(3)
        infoLabel.isHidden = false
        switch randomNumber {
        case 1:
            self.infoLabel.text = "total \(self.clickCounter) clicks were made."
        case 2:
            let formatedTime = String(format: "%.1f", self.timerCounter)
            self.infoLabel.text = "mage fight continued for \(formatedTime) human seconds."
        case 3:
            self.infoLabel.text = "total distance is \(self.totalDistance) km."
        default:
            self.infoLabel.text = "so what?"
            
        }
    }
    
    func startStatisticsTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateStatisticsTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateStatisticsTimer() {
        timerCounter += 0.1
    }
    
    func resetStatisticsTimer(){
        timer.invalidate()
        timerCounter = -3.0
    }
    
    func winLose(decider: Int) {
        InfoForTopMage.isHidden = false
        InfoForBottomMage.isHidden = false
            if decider == 1 {
                InfoForTopMage.text = losePhrasesGenerator()
                InfoForBottomMage.text = winPhrasesGenerator()
            }
            if decider == 2 {
                InfoForTopMage.text = winPhrasesGenerator()
                InfoForBottomMage.text = losePhrasesGenerator()
            }
    }
    
    func winPhrasesGenerator() -> String {
        let randomNumberForWinPhrases = arc4random_uniform(5)
        switch randomNumberForWinPhrases {
        case 1:
            return "you are the best!"
        case 2:
            return "strongest mage."
        case 3:
            return "amazing skill."
        case 4:
            return "domination!"
        default:
            return "winner winner."
        }
    }
    
    func losePhrasesGenerator() -> String {
        let randomNumberForLosePhrases = arc4random_uniform(6)
        switch randomNumberForLosePhrases {
        case 1:
            return "you are soo bad!"
        case 2:
            return "weakest mage."
        case 3:
            return "noone loves you."
        case 4:
            return "weaked sick."
        case 5:
            return "pussy."
        default:
            return "chicken chicken."
        }
    }
}


