//
//  LeveledPicture.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
import CoreMotion

public struct Vector3 {
    public var x: Float
    public var y: Float
    public var z: Float
    init() {
        self.x = 0.0
        self.y = 0.0
        self.z = 0.0
    }
    init(_ x:Float,_ y:Float,_ z:Float) {
        self.x = x
        self.y = y
        self.z = z
    }
}

class LeveledPicture: NSObject, NSCoding
{
    //var name: String
    var dateCreated: Date
    let imageKey: String
    var levels:Vector3
    var syncLevels:Vector3
    
    required init(coder aDecoder: NSCoder) {
        //name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        imageKey = aDecoder.decodeObject(forKey: "imageKey") as! String
        self.levels = Vector3()
        self.syncLevels = Vector3()
        super.init()
    }
    
    override init() {//name: String
        //self.name = name
        self.dateCreated = Date()
        self.imageKey = UUID().uuidString
        self.levels = Vector3()
        self.syncLevels = Vector3()
        self.levels = Vector3()
        self.syncLevels = Vector3()
        super.init()
    }
    convenience init(name: String, level:CMAcceleration, sync:CMAcceleration) {
        self.init()
        setLevels(level: level, sync: sync)
    }
    
    func setLevels(level:CMAcceleration, sync:CMAcceleration){
        self.levels = Vector3(Float(level.x),Float(level.y),Float(level.z))
        self.syncLevels = Vector3(Float(sync.x),Float(sync.y),Float(sync.z))
    }
    
    func testAllVariance(variance:Float)->Bool
    {
        print("\(testVarienceX(variance: variance)) \(testVarienceY(variance: variance)) \(testVarienceZ(variance: variance))")
        if testVarienceX(variance: variance) && testVarienceY(variance: variance) && testVarienceZ(variance: variance){
            return true
        }
        return false
    }
    func testVarienceX(variance:Float)->Bool
    {
        return testVarience(levels.x + 1, syncLevels.x + 1, variance)
    }
    func testVarienceY(variance:Float)->Bool
    {
        return testVarience(levels.y + 1, syncLevels.y + 1, variance)
    }
    func testVarienceZ(variance:Float)->Bool
    {
        return testVarience(levels.z + 1, syncLevels.z + 1, variance)
    }
    func testVarience(_ l:Float,_ s:Float,_ variance:Float)->Bool
    {
        //print("testVarience \(l) \(s+variance)  \(s-variance)")
        if l < s+variance &&  l > s-variance
        {
            return true
        }
        return false
    }


    /*func findVariance()->Float
    {
 
    }*/
    
    func encode(with aCoder: NSCoder) {
        //aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(imageKey, forKey: "imageKey")
    }
}
