//
//  NavigationBar + ClearBackground.swift
//  MISiS
//
//  Created by Vova SKR on 30.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setTitleFont() {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
        UINavigationBar.appearance().titleTextAttributes = attributes
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)]
    }
    
    func setClearBackground() {
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
