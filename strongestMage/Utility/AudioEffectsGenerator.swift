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
        case playButtonSound = 8
    }
    static let audioName: [[String]] = [
        ["heavenlyChoir", "hiddenMastersTeam", "fluffingADuck"],
        ["badFeeling", "choirSuspense", "dunDun", "helloThere", "illuminati", "inception", "kaBoom", "lifeIsALie", "mgsAlert", "mouseClick", "perfect", "prepare", "putYourHandsInTheAir", "reloading", "singleSuspense", "suddenSuspense", "suddenSuspense1", "suddenSuspense2", "suddenSuspense3", "suspense1", "suspense2", "suspense3", "suspense4", "surprise", "toInfinity", "windows"],
        ["beep", "boing", "ding", "kick", "punch1", "punch2", "punch3", "punch4", "punch5", "punch6"],
        ["boom", "burp", "dolphin", "fart", "fragOut", "fusRoDah", "getOverHere", "gibberish", "hereWeGo", "letsDoThis", "quad", "yell"],
        ["swoosh1", "swoosh2", "swoosh3", "swooshDramatic", "laser1", "laser2", "laser3", "laser4", "lightsaber1", "lightsaber2"],
        ["aFewInchesLater", "aFewMomentsLater", "crickets", "eventualy", "meanwhile", "oneEternityLater", "uhh", "waitingGame", "wind", "windowsError"],
        ["crowdCheering", "denied", "dominating",  "fail1", "fail2", "fail3", "femaleDominating", "femaleGodlike", "femaleHolyshit", "femaleHumiliation", "femaleMonsterkill", "femaleRampage", "femaleUnstoppable", "femaleWickedsick", "getNoscoped", "godlike", "haha", "headhunter", "holyshit", "howYouAre", "humiliation", "impressive", "killShot", "missionFailed", "mlgHorns", "monsterKill", "rampage", "sadMusic1", "superHotFire", "targetNeutralised", "titanicFail", "toasty", "toBeContinued", "triggerd", "unstoppable", "victory", "whatHappend", "wickedsick", "youSuck"],
        ["arnold", "haveAGreatTime", "minionWhat", "noPleaseNo"],
        ["femalePlay", "play"]
    ]
    
    static var player: AVAudioPlayer?
    
    static func getAudio(_ type: AudioType) -> String {
        let currAudio = audioName[type.rawValue]
        let randomIndex = Int(arc4random_uniform(UInt32(currAudio.count)))
        return currAudio[randomIndex]
    }
    
//    static func getAudio(_ type: Int) -> String {
//        let currAudio = audioName[type]
//        let randomIndex = Int(arc4random_uniform(UInt32(currAudio.count)))
//        return currAudio[randomIndex]
//    }

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
