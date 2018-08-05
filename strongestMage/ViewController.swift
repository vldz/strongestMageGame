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
    
    @IBOutlet weak var bottomMageWon: UIImageView!
    @IBOutlet weak var topMageWon: UIImageView!
    
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var readyTop: UIButton!
    @IBOutlet weak var readyTopPressed: UIImageView!
    @IBOutlet weak var readyBottomPressed: UIImageView!
    
    @IBOutlet weak var topTimerImage: UIImageView!
    @IBOutlet weak var bottomTimerImage: UIImageView!
    @IBOutlet weak var raySubview: UIView!
    
    @IBOutlet weak var restartBottom: UIButton!
    @IBOutlet weak var restartTop: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var imageYPosition = 0.0
    var readyCounter = 0
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
        topMageWon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTopPressed.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        restartTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.image = UIImage(named: String(totalTime))
        bottomTimerImage.image = UIImage(named: String(totalTime))
        topTimerImage.isHidden = true
        bottomTimerImage.isHidden = true
        
        
//        infoLabel.font = UIFont.init(name: "octin vintage b rg", size: 50)
//        let attribute = [NSAttributedStringKey.font: infoLabel.font!]
//        NSMutableAttributedString(string: infoLabel.text!, attributes: attribute)
//        infoLabel?.text = "hello"
        
        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ready(_ sender: Any) {
        readyCounter += 1
        readyButton.isHidden = true
        readyBottomPressed.isHidden = false
        if readyCounter % 2 == 0 {
            self.readyF()
        }
    }
    
    @IBAction func readyTop(_ sender: Any) {
        readyCounter += 1
        readyTop.isHidden = true
        readyTopPressed.isHidden = false
        if readyCounter % 2 == 0 {
            self.readyF()
        }
    }
    
    func readyF() {
        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
        imageYPosition = Double(self.circle.center.y)
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
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
                self.topMageWon.isHidden = false
                self.bottomMageWon.isHidden = true
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
                self.bottomMageWon.isHidden = false
                self.topMageWon.isHidden = true
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
        restartCounter += 1
        self.restartBottom.isHidden = true
        self.readyBottomPressed.isHidden = false
        resetStatisticsTimer()
        if restartCounter % 2 == 0 {
            self.restart()
            self.clickCounter = 1
            self.totalDistance = 25
        }
    }
    
    @IBAction func restarttopF(_ sender: Any) {
        restartCounter += 1
        self.restartTop.isHidden = true
        self.readyTopPressed.isHidden = false
        resetStatisticsTimer()
        if restartCounter % 2 == 0 {
            self.restart()
            self.clickCounter = 1
            self.totalDistance = 25
        }
    }
    
    func restart() {
        self.circle.center = CGPoint(x:raySubview.frame.width/2, y:raySubview.frame.height/2)
        imageYPosition = Double(self.circle.center.y)
        bottomMageWon.isHidden = true
        topMageWon.isHidden = true
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
        startTimer()
        startStatisticsTimer()
        infoLabel.isHidden = true
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
        readyTopPressed.isHidden = true
        readyBottomPressed.isHidden = true
        readyCounter = 0
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
        case 1:
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
}

