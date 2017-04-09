//
//  MoverProtocol.swift
//  BasicSpriteSheet
//
//  Created by Bryan Gough on 2017-04-09.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
import SpriteKit
protocol MoverProtocol {
    var sheet:BasicPeople { get set }
    var sprite:SKSpriteNode { get set }
    func doAction(action:String)
}
