//
//  CustomTextField.swift
//  MISiS
//
//  Created by Vova SKR on 08.02.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class CustomSizedTextField: UITextField {
    
    private let leftInsests: CGFloat = 12
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftInsests, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftInsests, dy: 0)
    }

}

class CustomSizedButton: UIButton {

    private let leftInsests: CGFloat = 12
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: leftInsests, bottom: 0, right: 0)
    }
}

class TextFieldWithImage: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 43, bottom: 0, right: 17)

    var disablePasting: Bool = false

    var image: UIImage? {
        willSet {
            if let image = newValue {
                leftViewMode = .always
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                leftView = imageView
            } else {
                leftViewMode = .never
                leftView = nil
            }
        }
    }

    func setupPlaceholder(text: String) {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UserColor.gray60,
                                                         .font: Fonts.demiBldFont]
        attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let side: CGFloat = 16.68
        let imageSize = CGSize(width: side, height: side)
        let imageY = (bounds.height / CGFloat(2)) - (imageSize.height / CGFloat(2))
        let imageOrigin = CGPoint(x: side, y: imageY)
        return CGRect(origin: imageOrigin, size: imageSize)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return !disablePasting
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
