//
//  MenuViewController.swift
//  strongestMage
//
//  Created by Vladislav Zelinskyi on 8/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: ViewController {
    
    @IBAction func playButton(_ sender: Any) {
        navigateToMainInterface()
    }
    
    @IBAction func skinButton(_ sender: Any) {
        navigateToMainInterface()
    }
    
    @IBAction func rulesButton(_ sender: Any) {
        navigateToMainInterface()
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        navigateToMainInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func navigateToMainInterface() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainMenuNavigationController") as? MainMenuNavigationController else {
            return
        }
        
        present(mainNavigationVC, animated: true, completion: nil)
    }
}
