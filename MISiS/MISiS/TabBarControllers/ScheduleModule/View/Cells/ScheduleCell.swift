//
//  ScheduleCell.swift
//  MISiS
//
//  Created by Vova SKR on 07.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    static let reuseID = "ScheduleCell"
    
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
        tableView.delegate = self
        tableView.dataSource = self
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
        
        contentView.backgroundColor = .systemPink
        setTableView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension ScheduleCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseID, for: indexPath) as! LessonCell
        cell.lessonGroups.text  = "!!1112222!!!"
        cell.lessonSubject.text = "Subject subjecy"
        cell.lessonTeacher.text = "Ivanov A.V."
        cell.lessonPlace.text = "Б-415"
        cell.lessonType.text = "Type"
        cell.lessonStartTime.text = "9:00"
        cell.lessonFinishTime.text = "10:35"
        cell.numberOfLesson.text = "\(indexPath.row)"
        
        return cell
    }
    
    
}
