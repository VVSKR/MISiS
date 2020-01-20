//
//  LessonModel.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

struct LessonModel {
    
    private let kind: String
    
    let day: Int
    let order: Int
    let week: Int
    let location: String
    let teacher: String
    let begins: String
    let ends: String
    
    public var type: Type? {
        guard let type = kind.slice(from: "(", to: ")") else { return nil}
        return Type(rawValue: type)
    }
    
    public var typeString: String {
        guard let type = type else { return ""}
        switch type {
        case .laboratory: return "Лабораторная"
        case .lecture: return "Лекция"
        case .practical: return "Практика"
        }
    }
    
    
    public var lessonName: String? {
        var lessonName = kind.replacingOccurrences(of: "(\(type!.rawValue))", with: "")
        lessonName = lessonName.replacingOccurrences(of: "1, 2 п.г. ", with: "")
        return lessonName
    }
    
    var dto: LessonModelDTO {
        var dto = LessonModelDTO()
        dto.day = day
        dto.order = order
        dto.kind = kind
        dto.week = week
        dto.location = location
        dto.teacher = teacher
        dto.begins = begins
        dto.ends = ends
        return dto
    }
    
    init(dto: LessonModelDTO) {
        day = dto.day ?? 0
        order = dto.order ?? 0
        kind = dto.kind ?? ""
        week = dto.week ?? 0
        location = dto.location ?? ""
        teacher = dto.teacher ?? ""
        begins = dto.begins ?? ""
        ends = dto.ends ?? ""
    }
    
    
    
    
}
