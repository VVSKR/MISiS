//
//  GSTouchesShowingWindow.swift
//  MISiS
//
//  Created by Vova SKR on 11.06.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

public class GSTouchesShowingWindow: UIWindow {
    let controller = GSTouchesShowingController()
    
    override public func sendEvent(_ event: UIEvent) {
        let touches = event.allTouches
        
        for touch in touches! {
            switch touch.phase {
            case .began:
                self.controller.touchBegan(touch, view: self)
                
            case .moved:
                self.controller.touchMoved(touch, view: self)
                
            case .ended, .cancelled:
                self.controller.touchEnded(touch, view: self)
            
            default:
                break
            }
        }
        super.sendEvent(event)
    }
}
