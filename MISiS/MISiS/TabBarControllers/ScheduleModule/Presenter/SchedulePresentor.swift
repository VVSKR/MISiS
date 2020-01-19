//
//  SchedulePresentor.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol ScheduleViewProtocol: class {
    
    func currentPosition() -> CGFloat
    func setPositionSegmentControll(position: CGFloat)
    func setTitle(_ title: String?)
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol ScheduleViewPresenterProtocol: class {
    init(view: ScheduleViewProtocol, schedule: [LessonModel], router: RouterProtocol)
    
    func setSegmentPosition()
    func getLessons(for day: Day) -> [LessonModel]
    func setCurrentWeek(for date: Date)
    func returnCurrentWeek() -> Int
    func setDataSourse(_ cell: ScheduleCell)
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class SchedulePresenter: ScheduleViewPresenterProtocol {
    
    weak var view: ScheduleViewProtocol?
    var router: RouterProtocol?
    var schedule: [LessonModel]
    
    private var currentWeek: Int = 1
    
    required init(view: ScheduleViewProtocol, schedule: [LessonModel], router: RouterProtocol) {
        self.view = view
        self.router = router
        self.schedule = schedule
        setCurrentWeek(for: Date())
        setTitle()
    }
    
    func setTitle() {
        view?.setTitle(Date().makeTitle())
    }
    
    func setSegmentPosition() {
        guard let position = view?.currentPosition()  else { return }
        view?.setPositionSegmentControll(position: position)
    }
    
    func getLessons(for day: Day) -> [LessonModel] {
        let week: Week = (currentWeek & 1) == 0 ? .upper : .lower // можно добавить глобальную переменную верхней и нижней недели, чтобы перезагружать коллекцию только если меняется неделся (добавить релоуд в дид сет)
        return schedule.filter { $0.day == day.rawValue && $0.week == week.rawValue }
    }
    
    func setCurrentWeek(for date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let week = calendar.component(.weekOfYear, from: date)
        currentWeek = week
    }
    
    func returnCurrentWeek() -> Int {
        return currentWeek
    }
    
    func setDataSourse(_ cell: ScheduleCell) {
        cell.dataSource = ScheduleDataSource(lessons: schedule, currentWeek: currentWeek)
    }
    
    func chooseDay(to day: Date) { // переименовать
        
        
    }
    
    
}
