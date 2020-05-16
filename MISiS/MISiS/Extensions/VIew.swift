//
//  VIew.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        DispatchQueue.main.async {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.duration = 0.6
            animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
            self.layer.add(animation, forKey: "shake")
        }
    }

    func configure() {
        self.layer.cornerRadius = 8
//        self.layer.borderColor = UIColor.systemBlue.cgColor
//        self.layer.borderWidth = 1
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3
    }
}

extension UIView {
    func addShadow(opacity: Float = 0.5, color: UIColor = .black, offset: CGSize = .zero, radius: CGFloat = 8) {
    
        (layer.shadowOpacity, layer.shadowColor, layer.shadowOffset, layer.shadowRadius) = (opacity, color.cgColor, offset, radius)
    }
}
