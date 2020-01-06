//
//  CampusPresentor.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

protocol CampusViewProtocol: class {
    
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol CampusViewPresenterProtocol: class {
    init(view: CampusViewProtocol)
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class CampusPresenter: CampusViewPresenterProtocol {
    
    weak var view: CampusViewProtocol?
    
    required init(view: CampusViewProtocol) {
        self.view = view
        
    }
    
}
