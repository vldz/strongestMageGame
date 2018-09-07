//
//  AudioEffectsGenerator.swift
//  strongestMage
//
//  Created by Vladislav Zelinskyi on 9/7/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import AVFoundation

class AudioEffectsGenerator {
    
    enum AudioType: Int {
        case menuSound = 0
        case readySound = 1
        case counterSound = 2
        case spellSound = 3
        case raySound = 4
        case waitSound = 5
        case winLoseSound = 6
        case goToMenuSound = 7
    }
    static let audioName: [[String]] = [
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        []
    ]
    
    
    var player: AVAudioPlayer?
    
    static func getAudio(_ type: AudioType) -> String {
        let currAudio = audioName[type.rawValue]
        let randomIndex = Int(arc4random_uniform(UInt32(currAudio.count)))
        return currAudio[randomIndex]
    }
    
    static func getAudio(_ type: Int) -> String {
        let currAudio = audioName[type]
        let randomIndex = Int(arc4random_uniform(UInt32(currAudio.count)))
        return currAudio[randomIndex]
    }

    static func playSound(_ type: AudioType) {
        let currAudio = audioName[type.rawValue]
        let randomIndex = Int(arc4random_uniform(UInt32(currAudio.count)))

        guard let url = Bundle.main.url(forResource: "\(currAudio[randomIndex])", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
