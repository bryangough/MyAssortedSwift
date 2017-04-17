//
//  PersonInjection.swift
//  BasicSpriteSheet
//
//  Created by Bryan Gough on 2017-04-09.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//


import SpriteKit

struct PersonInjection {
    var sheet:BasicPeople
    init(sheet:BasicPeople)
    {
        self.sheet = sheet
    }
    func getWalk()->[SKTexture]
    {
        return sheet.movingPerson1_walk()
    }
}

