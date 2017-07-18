//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by hyf on 16/12/7.
//  Copyright © 2016年 hyf. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController
{
    var blinking: Bool = false {
        didSet {
            startBlink()
        }
    }
    
    fileprivate struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(
                timeInterval: BlinkRate.ClosedDuration,
                target: self, selector: #selector(BlinkingFaceViewController.endBlink),
                userInfo: nil,
                repeats: false
            )
        }
    }
    
    func endBlink() {
        faceView.eyesOpen = true
        Timer.scheduledTimer(
            timeInterval: BlinkRate.OpenDuration,
            target: self, selector: #selector(BlinkingFaceViewController.startBlink),
            userInfo: nil,
            repeats: false
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
}
