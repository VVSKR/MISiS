//
//  ButtonWithIcon.swift
//  MISiS
//
//  Created by Vova SKR on 31.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class ButtonWithIcon: UIButton {
    
    private var labelText: String
    private var rightImage: UIImage?
    private var action: (() -> Void)?
    
    private var label: UILabel?
    private var image: UIImageView?

    init(infoAction: InfoAction) {
        
        self.labelText = infoAction.title
        self.rightImage = infoAction.icon
        self.action = infoAction.action
        
        super.init(frame: .zero)
        backgroundColor = UserColor.gray5
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        
        let imageView = UIImageView(image: rightImage)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.image = imageView
    }
    
    private func setupLabel() {
        guard let imageView = image else {
            return
        }
        let label = UILabel()
        
        label.textAlignment = .left
        label.text = labelText
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        self.label = label
    }
    
    @objc private func buttonAction() {
        action?()
    }
   
    
    
}
