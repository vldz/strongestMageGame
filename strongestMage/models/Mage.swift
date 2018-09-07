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
        self.body = body
        self.portal = portal
        self.ray = ray
        self.infoLabel = infoLabel
        self.readyButton = readyButton
        self.state = .initial
    }

    func handleStateChange(newState: State) {
        switch newState {
        case .initial:
            self.body.isEnabled = false
            self.portal.isHidden = true
            self.ray.isHidden = true
            self.infoLabel.isHidden = true
            self.readyButton.setTitle("ready?", for: .normal)
            //AudioEffectsGenerator.playSound(.readySound)
            self.readyButton.isEnabled = true
        case .countdown:
            self.infoLabel.isHidden = false
            self.readyButton.isHidden = true
        case .ready:
            self.readyButton.setTitle("ready!", for: .normal)
            self.readyButton.isEnabled = false
        case .active:
            self.body.isEnabled = true
            self.portal.isHidden = false
            self.ray.isHidden = false
            self.infoLabel.isHidden = true
        case .winner:
            showInfo(info: PhrasesGenerator.getPhrase(.win))
            self.state = .finished
        case .loser:
            showInfo(info: PhrasesGenerator.getPhrase(.lose))
            self.state = .finished
        case .finished:
            self.body.isEnabled = false
            self.portal.isHidden = true
            self.ray.isHidden = true
            self.readyButton.setTitle("restart?", for: .normal)
            self.readyButton.setTitleColor(UIColor(red: 0.00, green: 1.00, blue: 0.82, alpha: 1.0), for: .normal)
            self.readyButton.isEnabled = true
            self.readyButton.isHidden = false
        }
    }

    func moveRay(_ direction: Int, _ distance: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.ray.center.y += distance * CGFloat(direction)
        }, completion: nil)
    }

    func showInfo(info: String) {
        self.infoLabel.text = info
        self.infoLabel.isHidden = false
    }

    func isReady() -> Bool {
        return self.state == .ready
    }

    func setState(_ newState: State) {
        self.state = newState
    }
}
