//
//  UIButton + ActivityIndicator.swift
//  MISiS
//
//  Created by Vova SKR on 16.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class ButtonWithActivityIndicator: UIButton {

    private lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        setImage(UIImage(), for: .selected)

        let style: UIActivityIndicatorView.Style = .white
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)

        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true

        return activityIndicator
        }()

    func startActivity() {
        titleLabel?.alpha = 0
        isSelected = true
        activityIndicator.startAnimating()
    }

    func stopActivity() {
        titleLabel?.alpha = 1
        isSelected = false
        activityIndicator.stopAnimating()
    }
}
