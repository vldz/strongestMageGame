//
//  ViewController.swift
//  strongest mage
//
//  Created by vld on 5/30/18.
//  Copyright © 2018 vld. All rights reserved.
//

import UIKit
import Darwin
import Foundation

class GameViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBOutlet weak var topMage: UIButton!
    @IBOutlet weak var bottomMage: UIButton!
    @IBOutlet weak var bottomMagePortal: UIImageView!
    @IBOutlet weak var topMagePortal: UIImageView!
    @IBOutlet weak var topMageRay: UIImageView!
    @IBOutlet weak var bottomMageRay: UIImageView!

    @IBOutlet weak var readyBottom: UIButton!
    @IBOutlet weak var readyTop: UIButton!

    @IBOutlet weak var raySubview: UIView!

    @IBOutlet weak var InfoForTopMage: UILabel!
    @IBOutlet weak var InfoForBottomMage: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var menuButton: UIButton!
    
    var gameScene: GameScene?
    var topMageObject: Mage?
    var bottomMageObject: Mage?
    
    var skeletonPortals: [UIImage]!
    var flowerPortals: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.topMageObject = Mage(body: self.topMage, portal: self.topMagePortal, ray: self.topMageRay, infoLabel: self.InfoForTopMage, readyButton: self.readyTop)
        self.bottomMageObject = Mage(body: self.bottomMage, portal: self.bottomMagePortal, ray: self.bottomMageRay, infoLabel: self.InfoForBottomMage, readyButton: self.readyBottom)

        print(raySubview.bounds.height)
        self.gameScene = GameScene(topMage: topMageObject, bottomMage: bottomMageObject, raySubview: raySubview, infoLabel: infoLabel, menuButton: menuButton)

        self.view.backgroundColor = UIColor.black
        buttonTransformUpSideDown()

        self.skeletonPortals = [UIImage(named: "skeletonPortal-1"), UIImage(named: "skeletonPortal-2"), UIImage(named: "skeletonPortal-3"), UIImage(named: "skeletonPortal-2")] as! [UIImage]
        self.flowerPortals = [ UIImage(named: "flowerPortal-1"),  UIImage(named: "flowerPortal-2"),  UIImage(named: "flowerPortal-3")] as! [UIImage]
        
        self.topMagePortal.image =  UIImage.animatedImage(with: skeletonPortals, duration: 0.5)
        self.bottomMagePortal.image = UIImage.animatedImage(with: flowerPortals, duration: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonTransformUpSideDown() {
        self.topMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.InfoForTopMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.topMagePortal.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.topMageRay.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }

    @IBAction func ready(_ sender: Any) {
        self.bottomMageObject!.setState(.ready)
        self.gameScene!.setState(newState: .preparing)
        AudioEffectsGenerator.playSound(.readySound)
    }

    @IBAction func readyTop(_ sender: Any) {
        self.topMageObject!.setState(.ready)
        self.gameScene!.setState(newState: .preparing)
        AudioEffectsGenerator.playSound(.readySound)
    }


    @IBAction func moveToBottom(_ sender: Any) {
        self.gameScene!.moveRay(direction: 1)
    }

    @IBAction func moveToTop(_ sender: Any) {
        self.gameScene!.moveRay(direction: -1)
    }
    
    @IBAction func menuSound(_ sender: Any) {
        AudioEffectsGenerator.playSound(.goToMenuSound)
    }
    
}
