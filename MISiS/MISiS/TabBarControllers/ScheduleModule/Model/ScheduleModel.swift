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
    var schedule: [LessonModel]
    
    
    init(dto: ScheduleModelDTO) {
        success = dto.success ?? false
        schedule = dto.schedule?.map { LessonModel(dto: $0) } ?? []
    }
}






