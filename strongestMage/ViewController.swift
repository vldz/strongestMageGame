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

class ViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var ray: UIImageView!
    @IBOutlet weak var topMage: UIButton!
    @IBOutlet weak var bottomMage: UIButton!
    @IBOutlet weak var bottomMagePortal: UIImageView!
    @IBOutlet weak var topMagePortal: UIImageView!
    
    @IBOutlet weak var readyBottom: UIButton!
    @IBOutlet weak var readyTop: UIButton!

    @IBOutlet weak var raySubview: UIView!

    @IBOutlet weak var InfoForTopMage: UILabel!
    @IBOutlet weak var InfoForBottomMage: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    var gameScene: GameScene?
    var topMageObject: Mage?
    var bottomMageObject: Mage?
    
    var sceletonPortal1 : UIImage!
    var sceletonPortal2 : UIImage!
    var sceletonPortal3 : UIImage!
    var sceletonPortal4 : UIImage!
    var sceletonPortals: [UIImage]!
    var animatedSceletonPortal: UIImage!
    
    var flowerPortal1 : UIImage!
    var flowerPortal2 : UIImage!
    var flowerPortal3 : UIImage!
    var flowerPortals: [UIImage]!
    var animatedFlowerPortal: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        topMageObject = Mage(body: topMage, portal: topMagePortal, ray: ray, infoLabel: InfoForTopMage, readyButton: readyTop)
        bottomMageObject = Mage(body: bottomMage, portal: bottomMagePortal, ray: ray, infoLabel: InfoForBottomMage, readyButton: readyBottom)

        gameScene = GameScene(topMage: topMageObject, bottomMage: bottomMageObject, ray: ray, raySubview: raySubview, infoLabel: infoLabel)

        view.backgroundColor = UIColor.black
        buttonTransformUpSideDown()
        
        sceletonPortal1 = UIImage(named: "sceletonPortal-1")
        sceletonPortal2 = UIImage(named: "sceletonPortal-2")
        sceletonPortal3 = UIImage(named: "sceletonPortal-3")
        sceletonPortal4 = UIImage(named: "sceletonPortal-4")
        sceletonPortals = [sceletonPortal1, sceletonPortal2, sceletonPortal3, sceletonPortal4]
        
        flowerPortal1 = UIImage(named: "flowerPortal-1")
        flowerPortal2 = UIImage(named: "flowerPortal-2")
        flowerPortal3 = UIImage(named: "flowerPortal-3")
        flowerPortals = [flowerPortal1, flowerPortal2, flowerPortal3]
        
        animatedSceletonPortal = UIImage.animatedImage(with: sceletonPortals, duration: 0.6)
        topMagePortal.image = animatedSceletonPortal
        animatedFlowerPortal = UIImage.animatedImage(with: flowerPortals, duration: 0.6)
        bottomMagePortal.image = animatedFlowerPortal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonTransformUpSideDown() {
        topMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        InfoForTopMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        topMagePortal.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }

    @IBAction func ready(_ sender: Any) {
        bottomMageObject!.setState(newState: .ready)
        gameScene!.setState(newState: .preparing)
    }

    @IBAction func readyTop(_ sender: Any) {
        topMageObject!.setState(newState: .ready)
        gameScene!.setState(newState: .preparing)
    }


    @IBAction func moveToBottom(_ sender: Any) {
        gameScene!.moveRay(direction: 1)
    }

    @IBAction func moveToTop(_ sender: Any) {
        gameScene!.moveRay(direction: -1)
    }
}
