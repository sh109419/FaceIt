//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by hyf on 16/9/30.
//  Copyright © 2016年 hyf. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

   
    private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
        ("angry", FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown)),
        ("happy", FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile)),
        ("worried", FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk)),
        ("mischievious", FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin))
    ]
    
    @IBAction func addEmotionalFace(from segue: UIStoryboardSegue) {
        if let editor = segue.source as? ExpressionEditorViewController {
            emotionalFaces.append((editor.name, editor.expression))
            tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //print("emotionsview prepare segue")
        var destinationvc = segue.destination
        if let navigationvc = destinationvc as? UINavigationController {
            destinationvc = navigationvc.visibleViewController ?? destinationvc
        }
        // segue to show a face due to a selected-row
        if let facevc = destinationvc as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
                facevc.expression = emotionalFaces[indexPath.row].expression
                facevc.navigationItem.title = emotionalFaces[indexPath.row].name
            // segue to the new emotion editor
        } else if destinationvc is ExpressionEditorViewController {
            if let popoverPresentationController = segue.destination.popoverPresentationController {
                popoverPresentationController.delegate = self
            }
        }

            
        
    }
    
    //let instance = getEmotionsMVCinstanceCount()
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    // in horizontally compact environments
    // popovers by default adapt to be over full screen instead
    // (which is what a modal segue looks like)
    // we want that, but not in the case where it's also vertically compact
    // (that's only the case on iPhones in landscape orientation)
    // in that case, we do NOT want to adapt so we still get a popover
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
        ) -> UIModalPresentationStyle
    {
        if traitCollection.verticalSizeClass == .compact {
            return .none
        } else if traitCollection.horizontalSizeClass == .compact {
            return .overFullScreen
        } else {
            return .none
        }
    }

}
