//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by hyf on 16/9/30.
//  Copyright © 2016年 hyf. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

   
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "angry": FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("emotionsview prepare segue")
        var destinationvc = (segue.destinationViewController as! UINavigationController).topViewController
        if destinationvc is UINavigationController {
            destinationvc = (destinationvc as! UINavigationController).visibleViewController// topviewcontroller
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                }
            }
            if sender is UIButton {
               // facevc.title = sender?.currentTitle
                facevc.navigationItem.title = sender?.currentTitle
            }
        }
    }
    
    //let instance = getEmotionsMVCinstanceCount()

}
