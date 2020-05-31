//
//  CurrentGroupView.swift
//  MISiS
//
//  Created by Vova SKR on 30.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol CurrentGroupCellDelegate: class {
    
    func exitButtonTap()
}

class CurrentGroupCell: UITableViewCell {
    
    static let customTableViewCellIndentifire = "CurrentGroupCell"
    
    private let viewWithMargin = UIView()
    
    private var instituteLabel: UILabel?
    private var groupLabel: UILabel?
    
    private var changeGroupButton: UIButton?
    
    weak var delegate: CurrentGroupCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewWithMargin()
        sutupInstituteLabel()
        sutupGroupLabel()
        setupChangeGroupButton()
      
        contentView.backgroundColor = UserColor.gray5
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewWithMargin() {
           contentView.addSubview(viewWithMargin)
        viewWithMargin.addShadow(opacity: 0.2)
           viewWithMargin.translatesAutoresizingMaskIntoConstraints = false
           viewWithMargin.backgroundColor = .white
           viewWithMargin.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
           viewWithMargin.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
           viewWithMargin.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
           viewWithMargin.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       }
    
    private func sutupInstituteLabel() {
        let instituteLabel = UILabel()
        instituteLabel.textAlignment = .center
        instituteLabel.text = "Институт: \(UserDefaults.standard.returnUnstitute())"
        viewWithMargin.addSubview(instituteLabel)
        instituteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        instituteLabel.topAnchor.constraint(equalTo:  viewWithMargin.topAnchor, constant: 20).isActive = true
        instituteLabel.centerXAnchor.constraint(equalTo:  viewWithMargin.centerXAnchor).isActive = true
        instituteLabel.leadingAnchor.constraint(equalTo: viewWithMargin.leadingAnchor, constant: 20).isActive = true
        
        self.instituteLabel = instituteLabel
    }

    
    private func sutupGroupLabel() {
        guard let instituteLabel = instituteLabel else {
            return
        }
        let groupLabel = UILabel()
        groupLabel.textAlignment = .center
        groupLabel.text = "Группа: \(UserDefaults.standard.returmGroup())"
        viewWithMargin.addSubview(groupLabel)
        groupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        groupLabel.topAnchor.constraint(equalTo: instituteLabel.bottomAnchor, constant: 10).isActive = true
        groupLabel.centerXAnchor.constraint(equalTo: instituteLabel.centerXAnchor).isActive = true
        groupLabel.leadingAnchor.constraint(equalTo: instituteLabel.leadingAnchor).isActive = true
        
        self.groupLabel = groupLabel
    }
    
    private func setupChangeGroupButton() {
        guard let groupLabel = groupLabel else {
            return
        }
        let changeGroupButton = UIButton()
        changeGroupButton.titleLabel?.textAlignment = .center
        changeGroupButton.setTitle("Сменить группу", for: .normal)
        changeGroupButton.setTitleColor(.red, for: .normal)
        
        changeGroupButton.addTarget(self, action: #selector(changeGroupButtonTap), for: .touchUpInside)
        viewWithMargin.addSubview(changeGroupButton)
        changeGroupButton.translatesAutoresizingMaskIntoConstraints = false
        
        changeGroupButton.topAnchor.constraint(equalTo: groupLabel.bottomAnchor, constant: 15).isActive = true
        changeGroupButton.centerXAnchor.constraint(equalTo: groupLabel.centerXAnchor).isActive = true
        changeGroupButton.leadingAnchor.constraint(equalTo: groupLabel.leadingAnchor).isActive = true
        changeGroupButton.bottomAnchor.constraint(equalTo: viewWithMargin.bottomAnchor, constant: -20).isActive = true
        
        self.changeGroupButton = changeGroupButton
    }
    
    @objc private func changeGroupButtonTap() {
        delegate?.exitButtonTap()
    }
}
