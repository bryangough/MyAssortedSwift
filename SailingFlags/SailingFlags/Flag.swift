//
//  Flag.swift
//  SailingFlags
//
//  Created by Bryan Gough on 2017-04-15.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import Foundation
import UIKit

class Flag
{
    let flagID: String
    let title: String
    let image: String?
    let voice: String
    
    init(title: String, photoID: String, image:String ){
        self.title = title
        self.flagID = photoID
        self.image = image
        self.voice = ""
    }
}

extension Flag: Equatable {
    static func == (lhs: Flag, rhs: Flag) -> Bool {
        return lhs.flagID == rhs.flagID
    }
}
