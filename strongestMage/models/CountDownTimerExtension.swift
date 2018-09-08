//
//  CountDownTimerExtension.swift
//  strongestMage
//
//  Created by Dmytrii Ilchuk on 8/28/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation

extension GameScene {
    
    func startTimer() {
        
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func endTimer() {
        self.countdownTimer.invalidate()
        self.topMage.state = .active
        self.bottomMage.state = .active
        self.state = .active
    }

    @objc
    func updateTime() {
        self.totalTime -= 1
        if self.totalTime > 0 {
            AudioEffectsGenerator.playSound(.counterSound)
            updateTimerInfo()
        } else if self.totalTime == 0 {
            AudioEffectsGenerator.playSound(.spellSound)
            self.topMage.showInfo(info: PhrasesGenerator.getPhrase(.start))
            self.bottomMage.showInfo(info: PhrasesGenerator.getPhrase(.start))
        } else {
            endTimer()
        }
    }

    func updateTimerInfo() {
        self.topMage.showInfo(info: String(totalTime))
        self.bottomMage.showInfo(info: String(totalTime))
    }
}
