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
    
    public var type: String {
        guard let type = kind.slice(from: "(", to: ")") else { return ""}
        return type
    }
    
    public var lessonName: String? {
        return kind.replacingOccurrences(of: "(\(type))", with: "")
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
