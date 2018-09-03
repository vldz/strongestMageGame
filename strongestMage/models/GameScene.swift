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
    var infoLabel: UILabel!
    var raySubview: UIView!

    var countdownTimer: Timer!
    var totalTime = 3

    let distance: CGFloat
    let clicksToWin = 8
    var clickDifference = 0

    var clickCounter = 1
    var totalDistance: CGFloat = CGFloat(25)
    var timerCounter = 0.0
    var timer = Timer()
    var timerIsOn = false

    init(topMage: Mage!, bottomMage: Mage!, raySubview: UIView!, infoLabel: UILabel!) {
        self.topMage = topMage
        self.bottomMage = bottomMage
        self.raySubview = raySubview
        self.infoLabel = infoLabel
        self.distance = (raySubview.bounds.height) / CGFloat(Float((clicksToWin) * 2))
        setState(.initial)
    }

    func setState(newState: State) {
        self.state = newState
    }

    func handleStateChange(newState: State) {
        switch newState {
        case .initial:
            setupScene()
        case .preparing:
            self.raySubview.setNeedsLayout()
            self.raySubview.layoutIfNeeded()
            resetStatisticsTimer()
            self.clickCounter = 0
            self.clickDifference = 0
            self.totalDistance = 0
            if topMage.isReady() && bottomMage.isReady() {
                state = .countdown
            }
        case .countdown:
            self.totalTime = 3
            updateTimerInfo()
            self.infoLabel.isHidden = true
            self.topMage.state = .countdown
            self.bottomMage.state = .countdown
            startTimer()
        case .active:
            startStatisticsTimer()
            self.topMage.state = .active
            self.bottomMage.state = .active
        case .finished:
            self.randomInfo()
            self.state = .preparing
        }
    }


    func moveRay(direction: Int) {
        self.bottomMage.moveRay(direction, distance)
        self.topMage.moveRay(direction, distance)
        self.clickCounter += 1
        self.clickDifference += direction
        self.totalDistance += distance
        if abs(clickDifference) == clicksToWin {
            self.bottomMage.state = (clickDifference < 0) ? .winner : .loser
            self.topMage.state = (clickDifference > 0) ? .winner : .loser
            self.state = .finished
        }
    }

    func setupScene() {
        self.infoLabel.isHidden = true
        self.topMage.state = .initial
        self.bottomMage.state = .initial
    }

    func setState(_ newState: State) {
        self.state = newState
    }

    func randomInfo () {
        let randomNumber = arc4random_uniform(3)
        self.infoLabel.isHidden = false
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


}
