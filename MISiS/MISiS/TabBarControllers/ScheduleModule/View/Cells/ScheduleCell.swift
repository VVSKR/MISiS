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
    
    var headerLabel: UILabel?
    var tableView = UITableView()
    var header = UIView()
    var dayOftheWeekForHeader: String?
    
    var dataSource: ScheduleDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData() // разобраться с этим
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        setHeader()
        setLabel()
        setTableView()
        contentView.addShadow()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextForHeaderLabel(dayOfWeek: String?) {
        headerLabel?.text = dayOfWeek
    }
    
    private func setTableView() {
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.layer.cornerRadius = 20
        
        tableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setHeader() {
        header.backgroundColor = .clear
        header.addSeparator(at: .bottom, color: .black)
        
        contentView.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        header.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func setLabel() {
        headerLabel = UILabel()
        headerLabel?.textAlignment = .center

        headerLabel?.textColor = .black
        headerLabel?.text = dayOftheWeekForHeader
        headerLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.addSubview(headerLabel!)
        
        headerLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel?.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        headerLabel?.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        headerLabel?.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        headerLabel?.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
    }
}
