//
//  CustomTableViewCell.swift
//  MISiS
//
//  Created by Vova SKR on 31.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let customTableViewCellIndentifire = "CustomTableViewCell"
    
    private let viewWithMargin = UIView()
    private var labelText: String?
    private var leftImage: UIImage?
    
    private var action: (() -> Void)?
    
    private var label: UILabel = UILabel()
    private var leftImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewWithMargin()
        setupImageView()
        setupLabel()
        contentView.backgroundColor = UserColor.gray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(text: String?, image: UIImage?) {
        label.text = text
        leftImageView.image = image
    }
    
    private func setupViewWithMargin() {
        contentView.addSubview(viewWithMargin)
        viewWithMargin.addShadow(opacity: 0.2)
        viewWithMargin.translatesAutoresizingMaskIntoConstraints = false
        
        
        viewWithMargin.backgroundColor = .white
        viewWithMargin.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        viewWithMargin.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        viewWithMargin.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewWithMargin.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupImageView() {
        leftImageView.image = leftImage
        leftImageView.contentMode = .center
        viewWithMargin.addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        leftImageView.topAnchor.constraint(equalTo: viewWithMargin.topAnchor, constant: 5).isActive = true
        leftImageView.centerYAnchor.constraint(equalTo: viewWithMargin.centerYAnchor).isActive = true
        leftImageView.leadingAnchor.constraint(equalTo: viewWithMargin.leadingAnchor, constant: 20).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLabel() {
        
        label.textAlignment = .left
        label.text = labelText
        viewWithMargin.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: viewWithMargin.topAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: viewWithMargin.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: viewWithMargin.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalTo: leftImageView.heightAnchor).isActive = true
    
    }
    
    @objc private func buttonAction() {
        action?()
    }

}
