//
//  GameScene.swift
//  strongestMage
//
//  Created by Dmytrii Ilchuk on 8/17/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import UIKit

class GameScene {
    enum State {
        case initial
        case preparing
        case countdown
        case active
        case finished
    }

    var state: State! {
        willSet(newState) {
            handleStateChange(newState: newState)
        }
    }
    var topMage: Mage!
    var bottomMage: Mage!
    var ray: UIImageView!
    var infoLabel: UILabel!
    var raySubview: UIView!

    var countdownTimer: Timer!
    var totalTime = 3

    var clickCounter = 1
    var totalDistance = 25
    var timerCounter = -3.0
    var timer = Timer()
    var timerIsOn = false

    init(topMage: Mage!, bottomMage: Mage!,ray: UIImageView!, raySubview: UIView!, infoLabel: UILabel!) {
        self.topMage = topMage
        self.bottomMage = bottomMage
        self.ray = ray
        self.raySubview = raySubview
        self.infoLabel = infoLabel
        self.state = .initial
    }

    func setState(newState: State) {
        state = newState
    }

    func handleStateChange(newState: State) {
        switch newState {
        case .initial:
            setupScene()
        case .preparing:
            resetStatisticsTimer()
            self.clickCounter = 1
            self.totalDistance = 25
            if topMage.isReady() && bottomMage.isReady() {
                state = .countdown
            }
        case .countdown:
            totalTime = 3
            updateTimerInfo()
            infoLabel.isHidden = true
            topMage.state = .countdown
            bottomMage.state = .countdown
            startTimer()
        case .active:
            startStatisticsTimer()
            topMage.state = .active
            bottomMage.state = .active
            ray.isHidden = false
            self.ray.center = CGPoint(x:raySubview.frame.width / 2, y:raySubview.frame.height / 2)
        case .finished:
            self.topMage.state = (self.ray.center.y > 0) ? .winner : .loser
            self.bottomMage.state = (self.ray.center.y > 0) ? .loser : .winner
            self.randomInfo()
            self.ray.isHidden = true
            self.state = .preparing
        }
    }


    func moveRay(direction: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            if ( self.ray.center.y > 0 && self.ray.center.y < self.raySubview.bounds.height) {
                self.ray.center.y += CGFloat(25 * direction)
                self.clickCounter += 1
                self.totalDistance += 25
            } else {
                self.state = .finished
            }
        }, completion: nil)
    }

    func setupScene() {
        self.infoLabel.isHidden = true
        self.ray.isHidden = true
        topMage.state = .initial
        bottomMage.state = .initial
        self.ray.center = CGPoint(x:raySubview.frame.width / 2, y:raySubview.frame.height / 2)
    }

    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func endTimer() {
        countdownTimer.invalidate()
        topMage.state = .active
        bottomMage.state = .active
        self.state = .active
    }

    @objc
    func updateTime() {
        totalTime -= 1
        if totalTime > 0 {
            updateTimerInfo()
        } else if totalTime == 0 {
            topMage.showInfo(info: PhrasesGenerator.getPhrase(.start))
            bottomMage.showInfo(info: PhrasesGenerator.getPhrase(.start))
        } else {
            endTimer()
        }
    }

    func updateTimerInfo() {
        topMage.showInfo(info: String(totalTime))
        bottomMage.showInfo(info: String(totalTime))
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
        timerCounter = 0
    }
}
