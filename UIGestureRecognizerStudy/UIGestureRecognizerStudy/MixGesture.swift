//
//  MixGesture.swift
//  UIGestureRecognizerStudy
//
//  Created by Serhio Brit on 29.03.2021.
//

import UIKit

class MixGesture: UIGestureRecognizer {
    
    let requiredMovements = 2
    let distanceForMixGesture: CGFloat = 35
    
    enum MixingGestureDirection {
        case left
        case right
        case underfined
    }
    
    var mixingNumber = 0
    var mixingStartPoint: CGPoint = .zero
    var finalDirection: MixingGestureDirection = .underfined
    
    override func reset() {
        mixingNumber = 0
        mixingStartPoint = .zero
        finalDirection = .underfined
        
        if state == .possible {
            state = .failed
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard  let touch = touches.first else {
            return
        }
        mixingStartPoint = touch.location(in: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard  let touch = touches.first else {
            return
        }
        
        let mixingLocation = touch.location(in: view)
        
        let horizontalDifference = mixingLocation.x - mixingStartPoint.x
        
        if abs(horizontalDifference) < CGFloat(distanceForMixGesture) {
            return
        }
        
        let direction: MixingGestureDirection
        
        if horizontalDifference < 0 {
            direction = .left
        } else {
            direction = .right
        }
        
        if finalDirection == .underfined || (finalDirection == .left && direction == .right) || (finalDirection == .right && direction == .left) {
            
            mixingStartPoint = mixingLocation
            finalDirection = direction
            mixingNumber += 1
        }
        
        if state == .possible && mixingNumber > requiredMovements {
            state = .ended
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    
}
