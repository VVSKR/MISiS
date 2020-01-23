//
//  ScheduleCell.swift
//  MISiS
//
//  Created by Vova SKR on 07.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol CollectionCellProtocol {
    static var reuseID: String { get }
}

class ScheduleCell: UICollectionViewCell, CollectionCellProtocol {
    
    static let reuseID = "ScheduleCell"
    
    var dataSource: ScheduleDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData() // разобраться с этим
        }
    }
    
    var tableView = UITableView()
    
    private func setTableView() {
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        setTableView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
