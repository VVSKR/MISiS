//
//  TableView.swift
//  MISiS
//
//  Created by Vova SKR on 12.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        
        let imageView = UIImageView(image: UIImage(named: "noLessons"))
        let messageLabel = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -15),
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20)
        ])
            
            
            messageLabel.text = "День самостоятельных занятий"
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            
            self.isScrollEnabled = false
            self.backgroundView = emptyView
            self.separatorStyle = .none
    }
    
    func restore() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
