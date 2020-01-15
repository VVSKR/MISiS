//
//  CustomDataSourse.swift
//  MISiS
//
//  Created by Vova SKR on 11.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

struct LessonInfo {
    var time: String?
    var subject: String?
    var type: String?
    var place: String?
    var groups: String?
    var teacher: String?
}

class ScheduleDataSource: NSObject, UITableViewDataSource {

    var day: Day
    var lessons: [LessonInfo]
    var days: String?
    var month: Int?

    var selectedWeekFirstDay: Int? {
        if let days = days, days.contains(" - ") {
            let firstDay = days.components(separatedBy: " - ")[0]
            return Int(firstDay)
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let currentDayLessonsCount = lessons.count
//        handleEmptyState(for: tableView, cellAmount: currentDayLessonsCount)
//        return currentDayLessonsCount
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseID, for: indexPath) as! LessonCell
        
//        let lesson = lessons[indexPath.row]
        let lesson = lessons[0]
        let dayConstant = day.rawValue

        cell.lessonStartTime.text = lesson.time
        cell.lessonSubject.text = lesson.subject
        cell.lessonType.text = lesson.type
        cell.lessonPlace.text = lesson.place
        cell.lessonGroups.text = lesson.groups
        cell.lessonTeacher.text = lesson.teacher

        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let currentYear = calendar.component(.year, from: date)
        
        let lessonTimeString = lesson.time?.components(separatedBy: " - ")
        if let selectedWeekFirstDay = selectedWeekFirstDay, lessonTimeString?.count == 2,
            let lessonEndTimeComponents = lessonTimeString?.last?.components(separatedBy: ":"),
            lessonEndTimeComponents.count == 2,
            let hourComponent = lessonEndTimeComponents.first,
            let minuteComponent = lessonEndTimeComponents.last,
            let hour = Int(hourComponent),
            let minute = Int(minuteComponent),
            let currentMonthNumber = month,
            let lessonDate = calendar.date(from: DateComponents(calendar: calendar,
                                                                year: currentYear,
                                                                month: currentMonthNumber,
                                                                day: selectedWeekFirstDay + dayConstant,
                                                                hour: hour,
                                                                minute: minute)) {
            if lessonDate.timeIntervalSinceNow < 0 {
                cell.contentView.alpha = 0.65
//                cell.lessonStartTime.textColor = .systemRed
                cell.backgroundColor = UIColor(named: "outdatedCellBackground")
            } else {
                cell.contentView.alpha = 1
                cell.lessonStartTime.textColor = UIColor(named: "timeTextColor")
                cell.backgroundColor = .clear
            }
        } else {
            cell.backgroundColor = .clear
        }

        return cell
    }

    init(day: Day, lessons: [LessonInfo], days: String?, month: Int?) {
        self.day = day
        self.lessons = lessons
        self.days = days
        self.month = month
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
