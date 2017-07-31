//
//  EyeView.swift
//  FaceIt
//
//  Created by CS193p Instructor.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class EyeView: UIView
{
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }

    var _eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    
    var eyesOpen: Bool {
        get {
           return _eyesOpen
        }
        set {
            if newValue != _eyesOpen {
                // animate opening/closing the eyes
                UIView.transition(
                    with: self,
                    duration: 0.4,
                    options: [.transitionFlipFromTop],
                    animations: {
                        self._eyesOpen = newValue
                    }
                )
            }
            /*
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionFlipFromTop,.curveLinear],
                animations: {
                    self._eyesOpen = newValue
                },
                completion: nil
            )*/
        }
    }
    
    
    /*private func pathForEye(eye: Eye) -> UIBezierPath {
     let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
     let eyeCenter = getEyeCenter(eye)
     if eyesOpen {
     return pathForCircleCenterdAtPoint(eyeCenter, withRadius: eyeRadius)
     } else {
     let path = UIBezierPath()
     path.move(to: CGPoint(x: eyeCenter.x-eyeRadius, y: eyeCenter.y))
     path.addLine(to: CGPoint(x:eyeCenter.x+eyeRadius, y: eyeCenter.y))
     path.lineWidth = lineWidth
     return path
     }
     }*/


    override func draw(_ rect: CGRect)
    {
        var path: UIBezierPath!
        
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
        //print("draw eye")
    }
}
