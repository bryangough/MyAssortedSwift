//
//  BasicMover.swift
//  BasicSpriteSheet
//
//  Created by Bryan Gough on 2017-04-09.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//


import SpriteKit

class BasicMover: MoverProtocol {
    
    // 1
    var sheet:BasicPeople
    var sprite:SKSpriteNode
    let animationTime:TimeInterval = 0.1
    init(sheet:BasicPeople) {
        self.sheet = sheet
        self.sprite = SKSpriteNode(texture: sheet.movingPerson1_idle0001());
        self.sprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.sprite.size = CGSize(width: sprite.size.width, height: sprite.size.height)
        self.setupActions()
    }
    //
    var actions = [String: SKAction]()

    //
    func setupActions()
    {
        actions["walk"] = SKAction.animate(with: sheet.movingPerson1_walk(), timePerFrame: animationTime, resize: true, restore: true)
        actions["walkforever"] = SKAction.repeatForever(actions["walk"]!)
        actions["use"] = SKAction.animate(with: sheet.movingPerson1_use(), timePerFrame: animationTime, resize: true, restore: true)
        actions["idle"] = SKAction.animate(with: [sheet.movingPerson1_idle0001()], timePerFrame: animationTime, resize: true, restore: true)
        actions["idleForever"] = SKAction.repeatForever(actions["idle"]!)
        
        actions["fall"] = SKAction.animate(with: sheet.movingPerson1_die(), timePerFrame: animationTime, resize: true, restore: true)
        actions["staydown"] = SKAction.animate(with: [sheet.movingPerson1_die0007()], timePerFrame: animationTime, resize: true, restore: true)
        actions["stayDownForever"] = SKAction.repeatForever(actions["staydown"]!)
    }
    func doAction(action:String)
    {
        switch action {
        case "walk":
            doWalk()
        case "use":
            doUse()
        case "idle":
            doIdle()
        case "fall":
            doFall()
        default:
            doIdle()
        }
    }
    func getAction(_ action:String)->SKAction
    {
        if let skaction = actions[action]
        {
            return skaction
        }
        return actions["idle"]!
    }
    func doWalk()
    {
        sprite.run(getAction("walkforever"))
    }
    func doUse()
    {
        let sequence = SKAction.sequence([getAction("use"), getAction("idleForever")])
        sprite.run(sequence)
    }
    func doIdle()
    {
        
        sprite.run(actions["idleForever"]!);
    }
    func doFall()
    {
        let sequence = SKAction.sequence([getAction("fall"), getAction("stayDownForever")])
        sprite.run(sequence)
    }
    
}
