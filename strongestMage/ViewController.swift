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
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var topMage: UIButton!
    @IBOutlet weak var bottomMage: UIButton!

    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var readyTop: UIButton!
    
    @IBOutlet weak var topTimerImage: UIImageView!
    @IBOutlet weak var bottomTimerImage: UIImageView!
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
        
        topMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        InfoForTopMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        restartTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.image = UIImage(named: String(totalTime))
        bottomTimerImage.image = UIImage(named: String(totalTime))
        topTimerImage.isHidden = true
        bottomTimerImage.isHidden = true

        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
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
        
        InfoForTopMage.isHidden = true
        InfoForBottomMage.isHidden = true
        infoLabel.isHidden = true
        
        restartTop.isHidden = true
        restartTop.setTitle("restart?", for: .normal)
        restartBottom.isHidden = true
        restartBottom.setTitle("restart?", for: .normal)
        isReadyToRestartBottom = false
        isReadyToRestartTop = false
        
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
        startTimer()
        startStatisticsTimer()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        topTimerImage.isHidden = true
        bottomTimerImage.isHidden = true
        topMage.isEnabled = true
        bottomMage.isEnabled = true
        circle.isHidden = false
        totalTime = 3
        topTimerImage.image = UIImage(named: String(totalTime))
        bottomTimerImage.image = UIImage(named: String(totalTime))
    }
    
    @objc
    func updateTime() {
        totalTime -= 1
        if totalTime > 0 {
            topTimerImage.image = UIImage(named: String(totalTime))
            bottomTimerImage.image = UIImage(named: String(totalTime))
        } else if totalTime == 0 {
            topTimerImage.image = UIImage(named: "go!")
            bottomTimerImage.image = UIImage(named: "go!")
        } else {
            endTimer()
        }
    }
    
    func randomInfo () {
        let randomNumber = arc4random_uniform(4)
        infoLabel.isHidden = false
        switch randomNumber {
        case randomNumber:
            self.infoLabel.text = "total \(self.clickCounter) clicks were made."
        case 2:
            let formatedTime = String(format: "%.1f", self.timerCounter)
            self.infoLabel.text = "mage fight continued for \(formatedTime) human seconds."
        case 3:
            self.infoLabel.text = "total distance is \(self.totalDistance) km."
        default:
            self.infoLabel.text = "you're beautiful moma's little mage."
            
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
                InfoForTopMage.text = loseFrasesGenerator()
                InfoForBottomMage.text = winFrasesGenerator()
            }
            if decider == 2 {
                InfoForTopMage.text = winFrasesGenerator()
                InfoForBottomMage.text = loseFrasesGenerator()
            }
    }
    
    func winFrasesGenerator() -> String {
        let randomNumberForWinFrases = arc4random_uniform(5)
        switch randomNumberForWinFrases {
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
    
    func loseFrasesGenerator() -> String {
        let randomNumberForLoseFrases = arc4random_uniform(5)
        switch randomNumberForLoseFrases {
        case 1:
            return "you are soo bad!"
        case 2:
            return "weakest mage."
        case 3:
            return "noone loves you."
        case 4:
            return "weaked sick."
        default:
            return "chicken chicken."
        }
    }
}


