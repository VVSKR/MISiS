//
//  LessonModelDTO.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

struct LessonModelDTO: Decodable {
    
    let day: Int?
    let order: Int?
    let kind: String?
    let week: Int?
    let location: String?
    let teacher: String?
    let begins: String?
    let ends: String?
}
