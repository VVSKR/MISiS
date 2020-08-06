//
//  GSTouchesShowingGestureRecognizer.swift
//  MISiS
//
//  Created by Vova SKR on 11.06.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//


import UIKit
import UIKit.UIGestureRecognizerSubclass

public class GSTouchesShowingGestureRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    let touchesShowingController = GSTouchesShowingController()
    
    public init() {
        super.init(target: nil, action: nil)
        self.cancelsTouchesInView = false
        self.delaysTouchesBegan = false
        self.delaysTouchesEnded = false
        self.delegate = self
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            self.touchesShowingController.touchBegan(touch, view: self.view!)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            self.touchesShowingController.touchMoved(touch, view: self.view!)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            self.touchesShowingController.touchEnded(touch, view: self.view!)
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            self.touchesShowingController.touchEnded(touch, view: self.view!)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

