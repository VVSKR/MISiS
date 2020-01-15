//
//  LessonModelDTO.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

struct LessonModelDTO: Decodable {
    
    var day: Int?
    var order: Int?
    var kind: String?
    var week: Int?
    var location: String?
    var teacher: String?
    var begins: String?
    var ends: String?
}
