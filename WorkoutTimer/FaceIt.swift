//
//  FaceIt.swift
//  WorkoutTimer
//
//  Created by admin on 26.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView
{
    @IBInspectable
    var startX: CGFloat = 20
    var levelY: CGFloat = 200
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        let w = rect.width
        let point = viewWithTag(1)?.frame.minY
        let point2 = viewWithTag(2)?.frame.maxY
        levelY = (point2! + point!) / 2 - 5
        aPath.move(to: CGPoint(x:startX, y:levelY))
        
        aPath.addLine(to: CGPoint(x:w-startX, y:levelY))
        
        aPath.lineWidth = 5.0
        
        aPath.close()
        UIColor.red.set()
        aPath.stroke()
        aPath.fill()
    }
}
