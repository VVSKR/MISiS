//
//  Date.swift
//  MISiS
//
//  Created by Vova SKR on 10.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation


extension Date {
    func makeTitle() -> String? {
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        
        if let mondayDate = makeDate(from: .monday), let sundayDate = makeDate(from: .sunday) {
            return String(calendar.component(.day, from: mondayDate)) + " - " + formatter.string(from: sundayDate)
        } else {
            return nil
        }
    }
    
    func makeDate(from day: Day) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var comps = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: self)
        guard comps.weekOfYear != nil else { return nil }
        if day == .sunday {
            comps.weekOfYear! += 1
            comps.weekday = 1
        } else {
            if let weekDayFromComps = comps.weekday, weekDayFromComps == 1 {
                comps.weekOfYear! -= 1
            }
            comps.weekday = 2
        }
        
        return calendar.date(from: comps)
    }
    
    static func getWeekQuery() -> Date? {
        let currentDate = Date()
        let calendar = Calendar(identifier: .gregorian)
        var weekQuery: Date?
        if calendar.component(.weekday, from: currentDate) == 1 {
            weekQuery = calendar.date(from: DateComponents(
                calendar: calendar,
                year: calendar.component(.year, from: currentDate),
                month: calendar.component(.month, from: currentDate),
                day: calendar.component(.day, from: currentDate) + 1))
        } else if calendar.component(.weekday, from: currentDate) == 7 && calendar.component(.hour, from: currentDate) >= 18 {
            weekQuery = calendar.date(from: DateComponents(
                calendar: calendar,
                year: calendar.component(.year, from: currentDate),
                month: calendar.component(.month, from: currentDate),
                day: calendar.component(.day, from: currentDate) + 2))
        }
        return weekQuery
    }
    
    static func getIndexOfDayForSegmented() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let comps = calendar.dateComponents([.weekday, .hour], from: Date())
        let weekday = comps.weekday ?? 1
        let hour = comps.hour ?? 1
        var result: Int
        switch weekday {
        case 1: result =  0
        case 2: result =  0
        default: result = weekday - 2
        }
        
        if hour >= 18 {
            if weekday == 7 {
                result = 0
            } else if weekday != 1 && result != 7 {
                result += 1
            }
        }
        return result
    }
    
    static func getOrdinalityDayOfYearWithCurrentMonday() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = calendar.dateComponents([.hour, .weekOfMonth, .month, .year, .era, .weekday], from: currentDate)
        components.weekday = 2
        components.weekOfMonth = 1
        components.month = 9
        components.hour = 12
        
        guard let firstMondayOfSeptemberDate = calendar.date(from: components),
            let firstMondayOfSeptemberThisYear = calendar.ordinality(of: .day, in: .year, for: firstMondayOfSeptemberDate),
            let currentMonday = Date().makeDate(from: .monday)
            else {
                return 245
        }
        
        return calendar.ordinality(of: .day, in: .year, for: currentMonday) ?? firstMondayOfSeptemberThisYear
    }
    
    static func getOrdinalityDay(month: Int, day: Int) -> Int? {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = calendar.dateComponents([.hour, .day, .month, .year, .era], from: currentDate)
        components.day = day
        components.month = month
        components.hour = 12
        guard let date = calendar.date(from: components) else { return nil }
        return calendar.ordinality(of: .day, in: .year, for: date)
    }
    
}
