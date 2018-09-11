//
//  PhrasesGenerator.swift
//  strongestMage
//
//  Created by Dmytrii Ilchuk on 8/17/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation

class PhrasesGenerator {
    // must correspond to indexes in the array of phrases
    enum PhraseType: Int {
        case start = 0
        case win = 1
        case lose = 2
    }
    static let phrases: [[String]] = [
        ["alahu akbar.",
         "avada kedavra.",
         "fokusi-pokusi!",
         "pew? pew!",
         "wizard his ass!"],

        [ "you are the best!",
          "strongest mage.",
          "amazing skill.",
          "domination!",
          "winner winner.",
          "boiii!"],

        [ "you are soo bad!",
          "weakest mage.",
          "no one loves you.",
          "weaked sick.",
          "pussy.",
          "chicken chicken.",
          "you suck."]
    ]

    static func getPhrase(_ type: PhraseType) -> String {
        let currPhrases = phrases[type.rawValue]
        let randomIndex = Int(arc4random_uniform(UInt32(currPhrases.count)))
        return currPhrases[randomIndex]
    }

    static func getPhrase(_ type: Int) -> String {
        let currPhrases = phrases[type]
        let randomIndex = Int(arc4random_uniform(UInt32(currPhrases.count)))
        return currPhrases[randomIndex]
    }
}
