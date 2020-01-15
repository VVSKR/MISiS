//
//  SchedulePresentor.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol ScheduleViewProtocol: class {
    
    func currentPosition() -> CGFloat
    func setPositionSegmentControll(position: CGFloat)
    
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol ScheduleViewPresenterProtocol: class {
    init(view: ScheduleViewProtocol, router: RouterProtocol)
    
    func setSegmentPosition()
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class SchedulePresenter: ScheduleViewPresenterProtocol {
    
    weak var view: ScheduleViewProtocol?
    var router: RouterProtocol?
    
    required init(view: ScheduleViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func setSegmentPosition() {
        guard let position = view?.currentPosition()  else { return }
        view?.setPositionSegmentControll(position: position)
    }
    
}
