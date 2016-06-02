//
//  CGFloatExtension.swift
//  Rack_Runner
//
//  Created by Michael Hardin on 6/1/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    public static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    public static func random(min min: CGFloat, max:CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}

