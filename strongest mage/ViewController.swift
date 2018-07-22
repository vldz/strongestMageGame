//
//  ViewController.swift
//  strongest mage
//
//  Created by vld on 5/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import UIKit

    class ViewController: UIViewController {

    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var buttonTopStyle: UIButton!
    @IBOutlet weak var bottomMage: UIButton!
    @IBOutlet weak var bottomMageWon: UIImageView!
    @IBOutlet weak var topMageWon: UIImageView!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var reset: UIButton!
        
    var imageYPosition = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.black
        buttonTopStyle.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topMageWon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.reset.isHidden = true
        self.circle.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func ready(_ sender: Any) {
        self.readyF()
        readyButton.isHidden = true
        }
        
        func readyF() {
            self.circle.center = view.center
            imageYPosition = Double(self.circle.center.y)
            buttonTopStyle.isEnabled = true
            bottomMage.isEnabled = true
            circle.isHidden = false
        }
        
    @IBAction func restart(_ sender: Any) {
        self.resetRestart()
        readyButton.isHidden = false
    }
        
        func resetRestart () {
            reset.isHidden = true
            bottomMageWon.isHidden = true
            topMageWon.isHidden = true
        }
        
    @IBAction func moveToBottom(_ sender: Any) {
       UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
        if (self.imageYPosition != 533.5) {
            self.circle.center.y += 25
            self.imageYPosition = Double(self.circle.center.y)
            print(self.imageYPosition)
        } else {
            self.topMageWon.isHidden = false
            self.bottomMageWon.isHidden = true
            self.reset.isHidden = false
            self.buttonTopStyle.isEnabled = false
            self.bottomMage.isEnabled = false
            self.circle.isHidden = true
        }
        }, completion: nil)
    }
       
    @IBAction func moveToTop(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if (self.imageYPosition != 133.5) {
                self.circle.center.y -= 25
                self.imageYPosition = Double(self.circle.center.y)
                print(self.imageYPosition)
            } else {
                self.bottomMageWon.isHidden = false
                self.topMageWon.isHidden = true
                self.reset.isHidden = false
                self.buttonTopStyle.isEnabled = false
                self.bottomMage.isEnabled = false
                self.circle.isHidden = true
            }
        }, completion: nil)
    }
}

