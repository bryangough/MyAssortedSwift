//
//  GameScene.swift
//  BasicSpriteSheet
//
//  Created by Bryan Gough on 2017-04-09.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // 1
    let sheet = BasicPeople()
    
    var player:MoverProtocol
    var player2:MoverProtocol
    override init(size: CGSize) {
        
        self.player = BasicMover(sheet:sheet);
        self.player2 = BasicMover(sheet:sheet);
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player.sprite.position = CGPoint(x: size.width * 0.4, y: size.height * 0.5)
        addChild(player.sprite)
        
        player2.sprite.position = CGPoint(x: size.width * 0.8, y: size.height * 0.5)
        addChild(player2.sprite)
    }
    func doWalk()
    {
        player.doAction(action: "walk")
    }
    func doUse()
    {
        player.doAction(action: "use")
    }
    func doIdle()
    {
        player.doAction(action: "idle")
    }
    func doFall()
    {
        player.doAction(action: "fall")
    }

}
