//
//  GameViewController.swift
//  BasicSpriteSheet
//
//  Created by Bryan Gough on 2017-04-09.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
// https://www.raywenderlich.com/145318/spritekit-swift-3-tutorial-beginners

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene:GameScene!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func doFall(_ sender: Any) {
        scene.doFall()
    }
    @IBAction func doWalk(_ sender: Any) {
        scene.doWalk()
    }
    @IBAction func doIdle(_ sender: Any) {
        scene.doIdle()
    }
    @IBAction func doUse(_ sender: Any) {
        scene.doUse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
