//
//  MenuViewController.swift
//  strongestMage
//
//  Created by Vladislav Zelinskyi on 8/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: GameViewController {
    override func viewDidLoad() {
        
    }
    @IBAction func playButton(_ sender: Any) {
        navigateToMainInterface()
        AudioEffectsGenerator.playSound(.playButtonSound)
    }
    
    private func navigateToMainInterface() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationController else {
            return
        }
        
        present(mainNavigationVC, animated: false, completion: nil)
    }
}
