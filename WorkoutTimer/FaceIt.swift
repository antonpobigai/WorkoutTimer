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
    var startX: CGFloat = 100
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        let w = rect.width
        aPath.move(to: CGPoint(x:startX, y:300))
        
        aPath.addLine(to: CGPoint(x:w-startX, y:300))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        aPath.lineWidth = 5.0
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.black.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }
}
