//
//  CustomTextField.swift
//  MISiS
//
//  Created by Vova SKR on 08.02.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

extension UITextField {
    
    public static func logIn(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.placeholder = " " + placeholder
        
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.lightBlue.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 5.0
        textField.layer.shadowRadius = 0.0
        
        return textField
    }
    
   
}
