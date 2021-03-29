//
//  ViewController.swift
//  UIGestureRecognizerStudy
//
//  Created by Serhio Brit on 29.03.2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var purpleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mixingGesture = MixGesture(target: self, action: #selector(handleMixing))
        mixingGesture.delegate = self
        blueView.addGestureRecognizer(mixingGesture)
    }
    
    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        
        let blueViewFrame = blueView.frame
        let yellowViewFrame = yellowView.frame
        
        let gestureTranslation = gesture.translation(in: view)
        
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.center = CGPoint(x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
        
        gesture.setTranslation(.zero, in: view)
        
        guard gesture.state == .ended else {
            return
        }
        
        print("Blue view panned")
        
        for value in Int(yellowViewFrame.minY)...Int(yellowViewFrame.maxY) {
            if Int(blueViewFrame.origin.y) == value {
                blueView.isHidden = true
            }
        }
        
    }
    
    @IBAction func panActionPurple(_ gesture: UIPanGestureRecognizer) {
        
        let purpleViewFrame = purpleView.frame
        let yellowViewFrame = yellowView.frame
        
        let gestureTranslation = gesture.translation(in: view)
        
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.center = CGPoint(x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
        
        gesture.setTranslation(.zero, in: view)
        
        guard gesture.state == .ended else {
            return
        }
        
        print("Purple view panned")
        
        for value in Int(yellowViewFrame.minY)...Int(yellowViewFrame.maxY) {
            if Int(purpleViewFrame.origin.y) == value {
                purpleView.isHidden = true
            }
        }
    }
    
    @objc func handleMixing(_ gesture: MixGesture) {
        let yellowViewX = yellowView.frame.minX
        let yellowViewY = yellowView.frame.minY
        let yellowViewWidth = yellowView.frame.width
        let yellowViewHeight = yellowView.frame.height
        
        yellowView.frame = CGRect(x: yellowViewX, y: yellowViewY, width: yellowViewWidth - 30, height: yellowViewHeight)
        
    }
    
}


