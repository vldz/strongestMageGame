//
//  ViewController.swift
//  strongest mage
//
//  Created by vld on 5/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var buttonTopStyle: UIButton!
    @IBOutlet weak var bottomMage: UIButton!
    @IBOutlet weak var bottomMageWon: UIImageView!
    @IBOutlet weak var topMageWon: UIImageView!
    
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var readyTop: UIButton!
    @IBOutlet weak var readyTopPressed: UIImageView!
    @IBOutlet weak var readyBottomPressed: UIImageView!
    @IBOutlet weak var topTimerImage: UIImageView!
    @IBOutlet weak var bottomTimerImage: UIImageView!
    
    @IBOutlet weak var restartBottom: UIButton!
    @IBOutlet weak var restartTop: UIButton!
    
    var imageYPosition = 0.0
    var readyCounter = 0
    var restartCounter = 0
    var countdownTimer: Timer!
    var totalTime = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.black
        
        buttonTopStyle.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topMageWon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTopPressed.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        restartTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topTimerImage.image = UIImage(named: String(totalTime - 1))
        bottomTimerImage.image = UIImage(named: String(totalTime - 1))
        topTimerImage.isHidden = true
        bottomTimerImage.isHidden = true
        
        self.circle.center = view.center
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
        self.circle.center = view.center
        imageYPosition = Double(self.circle.center.y)
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
        startTimer()
    }
    
    @IBAction func moveToBottom(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if (self.imageYPosition < Double(UIScreen.main.bounds.height) - Double(self.bottomMage.bounds.height)) {
                self.circle.center.y += 25
                self.imageYPosition = Double(self.circle.center.y)
                print(self.imageYPosition)
            } else {
                self.topMageWon.isHidden = false
                self.bottomMageWon.isHidden = true
                self.buttonTopStyle.isEnabled = false
                self.bottomMage.isEnabled = false
                self.circle.isHidden = true
                self.restartBottom.isHidden = false
                self.restartTop.isHidden = false
            }
        }, completion: nil)
    }
    
    @IBAction func moveToTop(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if (self.imageYPosition > Double(self.buttonTopStyle.bounds.height)) {
                self.circle.center.y -= 25
                self.imageYPosition = Double(self.circle.center.y)
                print(self.imageYPosition)
            } else {
                self.bottomMageWon.isHidden = false
                self.topMageWon.isHidden = true
                self.buttonTopStyle.isEnabled = false
                self.bottomMage.isEnabled = false
                self.circle.isHidden = true
                self.restartBottom.isHidden = false
                self.restartTop.isHidden = false
            }
        }, completion: nil)
    }
   
    @IBAction func restartBottomButton(_ sender: Any) {
        restartCounter += 1
        self.restartBottom.isHidden = true
        self.readyBottomPressed.isHidden = false
            if restartCounter % 2 == 0 {
            self.restart()
        }
    }

    
    @IBAction func restarttopF(_ sender: Any) {
        restartCounter += 1
        self.restartTop.isHidden = true
        self.readyTopPressed.isHidden = false
        if restartCounter % 2 == 0 {
            self.restart()
        }
    }
    
    func restart() {
        self.circle.center = view.center
        imageYPosition = Double(self.circle.center.y)
        bottomMageWon.isHidden = true
        topMageWon.isHidden = true
        topTimerImage.isHidden = false
        bottomTimerImage.isHidden = false
        startTimer()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        topTimerImage.isHidden = true
        bottomTimerImage.isHidden = true
        buttonTopStyle.isEnabled = true
        bottomMage.isEnabled = true
        circle.isHidden = false
        readyTopPressed.isHidden = true
        readyBottomPressed.isHidden = true
        readyCounter = 0
        totalTime = 4
        topTimerImage.image = UIImage(named: String(totalTime - 1))
        bottomTimerImage.image = UIImage(named: String(totalTime - 1))
    }
    
    @objc
    func updateTime() {
        totalTime -= 1
        if totalTime > 1 {
            topTimerImage.image = UIImage(named: String(totalTime - 1))
            bottomTimerImage.image = UIImage(named: String(totalTime - 1))
        } else if totalTime == 1 {
            topTimerImage.image = UIImage(named: "go!")
            bottomTimerImage.image = UIImage(named: "go!")
        } else {
            endTimer()
        }
    }
}

