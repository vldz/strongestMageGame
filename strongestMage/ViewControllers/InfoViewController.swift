//
//  InfoViewController.swift
//  strongestMage
//
//  Created by Vladislav Zelinskyi on 9/4/18.
//  Copyright © 2018 vld. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBAction func emailTo(_ sender: Any) {
        let email = "vanillastorm420@gmail.com"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.open(url!)
    }
    
    override func viewDidLoad() {
    }
}
