//
//  Day.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

enum Day: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
}

enum Week: Int { // not use
    case upper = 1
    case lower = 0
}


enum CourseBachelor: Int {
    case first = 19
    case second = 18
    case third = 17
    case fourth = 16
    
    var group: String {
        switch self {
        case .first: return "1 курс"
        case .second: return "2 курс"
        case .third: return "3 курс"
        case .fourth: return "4 курс"
        }
    }
}

enum CourseMaga: Int {
    case first = 19
    case second = 18
    
    var group: String {
        switch self {
        case .first: return "1 курс магистратура"
        case .second: return "2 курс магистратура"
        }
    }
}
