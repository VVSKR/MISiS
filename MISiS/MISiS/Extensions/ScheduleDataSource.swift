//
//  CustomDataSourse.swift
//  MISiS
//
//  Created by Vova SKR on 11.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit


class ScheduleDataSource: NSObject, UITableViewDataSource {
    
    var lessons: [LessonModel]
    var currentWeek: Int?
    
    init( lessons: [LessonModel], currentWeek: Int) {
        self.currentWeek = currentWeek
        self.lessons = lessons
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentDayLessonsCount = lessons.count
        handleEmptyState(for: tableView, cellAmount: currentDayLessonsCount)
        return currentDayLessonsCount

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseID, for: indexPath) as! LessonCell
        let lesson = lessons[indexPath.row]
        
        cell.set(lesson: lesson)
        
        
        guard let lessonStartTime = getLessonData(time: lesson.begins),
            let lessonEndTime = getLessonData(time: lesson.ends) else { return cell }
        print("--------\(indexPath.row)-------")
        print(lessonStartTime.timeIntervalSinceNow < 0)
        
        print(lessonEndTime.timeIntervalSinceNow > 0)
        
        if lessonEndTime.timeIntervalSinceNow < 0 {
            cell.contentView.alpha = 0.5
        } else {
             cell.contentView.alpha = 1
        }
        
        
        if lessonStartTime.timeIntervalSinceNow < 0 && lessonEndTime.timeIntervalSinceNow > 0 {
//            cell.lessonSubject.backgroundColor =  .lightBlue
        } else {
//            cell.lessonSubject.backgroundColor =  .clear
        }
        return cell
        
    }
    
    
    
    func getLessonData(time: String) -> Date? {
        
        let lessonTime = time.components(separatedBy: ":")
        guard let hourString = lessonTime.first, let minuteString = lessonTime.last else { return nil }
        
        let hour = Int(hourString)
        let minute = Int(minuteString)
        
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.weekday = lessons[0].day + 1
        dateComponents.weekOfYear = currentWeek
        dateComponents.yearForWeekOfYear = calendar.component(.year, from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        return calendar.date(from: dateComponents)
    }
}

extension ScheduleDataSource {
    func handleEmptyState(for tableView: UITableView, cellAmount: Int) {
        if cellAmount == 0 {
            tableView.setEmptyView()
        } else {
            tableView.restore()
        }
    }
}
