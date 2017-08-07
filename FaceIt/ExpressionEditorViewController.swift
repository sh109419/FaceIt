//
//  ExpressionEditorViewController.swift
//  FaceIt
//
//  Created by hyf on 17/7/27.
//  Copyright © 2017年 hyf. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController, UITextFieldDelegate {
    
    var name: String {
        /*if nameTextField?.text == nil || nameTextField.text!.isEmpty {
            return "unknown"
        } else {
            return nameTextField.text!
        }*/
        return nameTextField?.text ?? "unknown"
    }
    
    private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
    private let mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin, .smile]
    private let eyeBrowChoices = [FacialExpression.EyeBrows.relaxed, .normal, .furrowed]
    
    var expression: FacialExpression {
        return FacialExpression(eyes: eyeChoices[eyeControl?.selectedSegmentIndex ?? 0],
                                eyeBrows: eyeBrowChoices[eyebrowControl?.selectedSegmentIndex ?? 0],
                                mouth: mouthChoices[mouthControl?.selectedSegmentIndex ?? 0])
    }
    
    @IBAction func updateFace() {
        faceViewController?.expression = expression
            //print("\(name) = \(expression)")
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    @IBOutlet weak var eyebrowControl: UISegmentedControl!
    
    private var faceViewController: BlinkingFaceViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Face" {
            faceViewController = segue.destination as? BlinkingFaceViewController
            faceViewController?.expression = expression
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Add Emotion", name.isEmpty {
            handleUnnamedFace()
            return false
        } else {
            return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    private func handleUnnamedFace() {
        let alert = UIAlertController(title: "invalid Face", message: "A face must have a name.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.presentingViewController?.dismiss(animated: true) }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let text = alert.textFields?.first?.text
            self.nameTextField?.text = alert.textFields?.first?.text
            if !(text!.isEmpty) {
                self.performSegue(withIdentifier: "Add Emotion", sender: nil)
            }
        }))
        alert.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        present(alert, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let popoverPresentationController = navigationController?.popoverPresentationController {
            if popoverPresentationController.arrowDirection != .unknown {
                navigationItem.leftBarButtonItem = nil
            }
        }
        // set the preferred content size
        // so that when we appear in a popover
        // we'll be a good size
        var size = tableView.minimumSize(forSection: 0)
        // adjust for the fact that we still want row 1 to be square
        // in this preferred size
        size.height -= tableView.heightForRow(at: IndexPath(row: 1, section: 0))
        size.height += size.width
        preferredContentSize = size
    }
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.width
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}

extension UITableView
{
    // warning: this forces a cell to be created for every row in that section
    // thus this only makes sense for smaller tables
    // it also does not account for any section headers or footers
    // it may well have other restrictions too :)
    func minimumSize(forSection section: Int) -> CGSize {
        var width: CGFloat = 0
        var height : CGFloat = 0
        for row in 0..<numberOfRows(inSection: section) {
            let indexPath = IndexPath(row: row, section: section)
            if let cell = cellForRow(at: indexPath) ?? dataSource?.tableView(self, cellForRowAt: indexPath) {
                let cellSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
                width = max(width, cellSize.width)
                height += heightForRow(at: indexPath)
            }
        }
        return CGSize(width: width, height: height)
    }
    
    func heightForRow(at indexPath: IndexPath? = nil) -> CGFloat {
        if indexPath != nil, let height = delegate?.tableView?(self, heightForRowAt: indexPath!) {
            return height
        } else {
            return rowHeight
        }
    }
}

