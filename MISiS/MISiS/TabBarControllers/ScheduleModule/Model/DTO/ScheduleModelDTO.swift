//
//  ScheduleModelDTO.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

struct ScheduleModelDTO: Decodable {
    
    var success: Bool?
    var schedule: [LessonModelDTO]?
}
