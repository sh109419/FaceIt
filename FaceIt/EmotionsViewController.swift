//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by hyf on 16/9/30.
//  Copyright © 2016年 hyf. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

   
    fileprivate let emotionalFaces: Dictionary<String,FacialExpression> = [
        "angry": FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown),
        "happy": FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        "worried": FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        "mischievious": FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin)
    ]
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("emotionsview prepare segue")
        var destinationvc = (segue.destination as! UINavigationController).topViewController
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
                facevc.navigationItem.title = (sender as AnyObject).currentTitle
            }
        }
    }
    
    //let instance = getEmotionsMVCinstanceCount()

}
