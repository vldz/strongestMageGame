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

    @IBOutlet weak var readyBottom: UIButton!
    @IBOutlet weak var readyTop: UIButton!

    @IBOutlet weak var raySubview: UIView!

    @IBOutlet weak var InfoForTopMage: UILabel!
    @IBOutlet weak var InfoForBottomMage: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    var gameScene: GameScene?
    var topMageObject: Mage?
    var bottomMageObject: Mage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        topMageObject = Mage(body: topMage, ray: ray, infoLabel: InfoForTopMage, readyButton: readyTop)
        bottomMageObject = Mage(body: bottomMage, ray: ray, infoLabel: InfoForBottomMage, readyButton: readyBottom)

        gameScene = GameScene(topMage: topMageObject, bottomMage: bottomMageObject, ray: ray, raySubview: raySubview, infoLabel: infoLabel)

        view.backgroundColor = UIColor.black
        buttonTransformUpSideDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonTransformUpSideDown() {
        topMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        InfoForTopMage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        readyTop.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
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
