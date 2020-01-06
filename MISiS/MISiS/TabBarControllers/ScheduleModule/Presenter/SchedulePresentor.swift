//
//  SchedulePresentor.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

protocol ScheduleViewProtocol: class {
    
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol ScheduleViewPresenterProtocol: class {
    init(view: ScheduleViewProtocol, router: RouterProtocol)
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class SchedulePresenter: ScheduleViewPresenterProtocol {
    
    weak var view: ScheduleViewProtocol?
    var router: RouterProtocol?
    
    
    required init(view: ScheduleViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
