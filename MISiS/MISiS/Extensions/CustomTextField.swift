//
//  CustomTextField.swift
//  MISiS
//
//  Created by Vova SKR on 08.02.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class CustomSizedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 7, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 7, dy: 0)
    }

}

class CustomSizedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
    }
}
