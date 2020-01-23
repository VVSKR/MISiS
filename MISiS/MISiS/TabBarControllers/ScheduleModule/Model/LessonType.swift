//
//  LessonType.swift
//  MISiS
//
//  Created by Vova SKR on 20.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

enum Type: String {
    case practical = "Практические"
    case laboratory = "Лабораторные"
    case lecture = "Лекционные"
    
    var typeName: String {
        switch self {
        case .laboratory: return "Лабораторная"
        case .lecture: return "Лекция"
        case .practical: return "Практика"
        }
    }
}
