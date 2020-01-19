//
//  LessonCell.swift
//  MISiS
//
//  Created by Vova SKR on 07.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {
    
    static let reuseID = "LessonCell"
    
    let colorLessonType = UIView()
    let numberOfLesson = UILabel()
    
    let lessonTimeStackView = UIStackView()
    let lessonStartTime = UILabel()
    let lessonFinishTime = UILabel()
    let lessonPlace = UILabel()
    
    let lessonStackView = UIStackView()
    let lessonSubject = UILabel()
    let lessonType = UILabel()
    let lessonTeacher = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setColorView()
        setNumberOfLesson()
        setLessonTime()
        setLessonPlace()
        setLesson()
    }
    
    func set(lesson: LessonModel) {
        lessonStartTime.text = lesson.begins
        lessonFinishTime.text = lesson.ends
        lessonSubject.text = lesson.lessonName
        lessonType.text = lesson.type
        lessonPlace.text = lesson.location
        lessonTeacher.text = lesson.teacher
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LessonCell {
    
    func setColorView() {
        
        colorLessonType.layer.cornerRadius = 2
        colorLessonType.backgroundColor = .systemPink
        
        contentView.addSubview(colorLessonType)
        colorLessonType.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorLessonType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -2),
            colorLessonType.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorLessonType.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            colorLessonType.widthAnchor.constraint(equalToConstant: 7)
        ])
    }
    
    func setNumberOfLesson() {
        numberOfLesson.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        numberOfLesson.textAlignment = .center
        contentView.addSubview(numberOfLesson)
        numberOfLesson.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOfLesson.leadingAnchor.constraint(equalTo: colorLessonType.leadingAnchor, constant: 15),
            numberOfLesson.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    func setLessonTime() {
        
        lessonStartTime.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lessonStartTime.textAlignment = .center
        
        lessonFinishTime.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lessonFinishTime.textAlignment = .center
        
        lessonTimeStackView.addArrangedSubview(lessonStartTime)
        lessonTimeStackView.addArrangedSubview(lessonFinishTime)
        
        lessonTimeStackView.distribution = .fillEqually
        lessonTimeStackView.axis = .vertical
        lessonTimeStackView.layoutMargins = UIEdgeInsets(top: 2, left: 15, bottom: 0, right: 0)
        lessonTimeStackView.isLayoutMarginsRelativeArrangement = true
        lessonTimeStackView.addSeparator(at: .left, color: .lightGray)
                
        contentView.addSubview(lessonTimeStackView)
        lessonTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lessonTimeStackView.leadingAnchor.constraint(equalTo: numberOfLesson.leadingAnchor, constant: 25),
            lessonTimeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lessonTimeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
            
        ])
    }
    
    
    func setLesson() {
        
        lessonSubject.font = UIFont.boldSystemFont(ofSize: 17)
        lessonSubject.numberOfLines = 1
        
        lessonType.font = UIFont.systemFont(ofSize: 15)
        
        lessonTeacher.font = UIFont.systemFont(ofSize: 15)
        lessonTeacher.textColor = .darkGray
        
        lessonStackView.addArrangedSubview(lessonSubject)
        lessonStackView.addArrangedSubview(lessonType)
        lessonStackView.addArrangedSubview(lessonTeacher)
        lessonStackView.alignment = .fill
        
        lessonStackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        lessonStackView.isLayoutMarginsRelativeArrangement = true
        
        lessonStackView.distribution = .equalCentering
        lessonStackView.axis = .vertical
        lessonStackView.spacing = 5
        lessonStackView.addSeparator(at: .left, color: .lightGray)
                
        contentView.addSubview(lessonStackView)
        lessonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lessonStackView.leadingAnchor.constraint(equalTo: lessonTimeStackView.trailingAnchor, constant: 10),
            lessonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            lessonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            lessonStackView.trailingAnchor.constraint(equalTo: lessonPlace.leadingAnchor, constant: -10)
        ])
    }
    
    func setLessonPlace() {
        lessonPlace.font = UIFont.systemFont(ofSize: 15)
        lessonPlace.textAlignment = .right
        contentView.addSubview(lessonPlace)
        
        lessonPlace.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonPlace.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            lessonPlace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        
    }
}
