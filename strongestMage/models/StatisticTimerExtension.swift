//
//  StatisticTimerExtension.swift
//  strongestMage
//
//  Created by Dmytrii Ilchuk on 8/28/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation

extension GameScene {
    func startStatisticsTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateStatisticsTimer), userInfo: nil, repeats: true)
    }

    @objc func updateStatisticsTimer() {
        self.timerCounter += 0.1
    }

    func resetStatisticsTimer(){
        self.timer.invalidate()
        self.timerCounter = 0
    }
}
