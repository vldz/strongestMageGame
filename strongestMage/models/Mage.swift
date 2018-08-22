//
//  Mage.swift
//  strongestMage
//
//  Created by Dmytrii Ilchuk on 8/17/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import UIKit
class Mage {
    enum State {
        case initial
        case ready
        case countdown
        case active
        case winner
        case loser
        case finished
    }
    var state: State! {
        willSet(newState) {
            handleStateChange(newState: newState)
        }
    }
    var body: UIButton!
    var ray: UIImageView!
    var portal: UIImageView!
    var infoLabel: UILabel!
    var readyButton: UIButton!

    init(body : UIButton, portal: UIImageView, ray: UIImageView, infoLabel: UILabel, readyButton: UIButton) {
        self.state = .initial
        self.body = body
        self.portal = portal
        self.ray = ray
        self.infoLabel = infoLabel
        self.readyButton = readyButton
    }

    func handleStateChange(newState: State) {
        switch newState {
        case .initial:
            body.isEnabled = false
            portal.isHidden = true
            ray.isHidden = true
            infoLabel.isHidden = true
            readyButton.setTitle("ready?", for: .normal)
            readyButton.isEnabled = true
        case .countdown:
            infoLabel.isHidden = false
            readyButton.isHidden = true
        case .ready:
            readyButton.setTitle("ready!", for: .normal)
            readyButton.isEnabled = false
        case .active:
            body.isEnabled = true
            portal.isHidden = false
        // TODO: use separate ray for each mage
            infoLabel.isHidden = true
        case .winner:
            showInfo(info: PhrasesGenerator.getPhrase(.win))
            state = .finished
        case .loser:
            showInfo(info: PhrasesGenerator.getPhrase(.lose))
            state = .finished
        case .finished:
            body.isEnabled = false
            portal.isHidden = true
        // TODO: Handle separate ray
            readyButton.setTitle("restart?", for: .normal)
            readyButton.setTitleColor(UIColor(red: 0.00, green: 1.00, blue: 0.82, alpha: 1.0), for: .normal)
            readyButton.isEnabled = true
            readyButton.isHidden = false
        }
    }

    func showInfo(info: String) {
        infoLabel.text = info
        infoLabel.isHidden = false
    }

    func isReady() -> Bool {
        return state == .ready
    }

    func setState(newState: State) {
        self.state = newState
    }
}
