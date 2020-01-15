//
//  Model.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

struct ScheduleModel {
    let success: Bool
    let schedule: [LessonModel]
}

// MARK: - Schedule
struct LessonModel {
    
    let day: Int
    let order: Int
    let kind: String
    let week: Int
    let location: String
    let teacher: String
    let begins: String
    let ends: String
    
    var dto: ScheduleModelDTO
    
    var type: String {
        guard let type = kind?.slice(from: "(", to: ")") else { return ""}
        return type
    }
    
    var lessonName: String? {
        return kind?.replacingOccurrences(of: "(\(type))", with: "")
    }
}


let  test = Schedule(day: 1, order: 1, kind: "Математика (Практика)", week: 1, location: "", teacher: "techer", begins: "10", ends: "12")




