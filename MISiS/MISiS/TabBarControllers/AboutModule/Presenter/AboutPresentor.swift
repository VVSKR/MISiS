//
//  AboutPresentor.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation


protocol AboutViewProtocol: class {
    
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol AboutViewPresenterProtocol: class {
    
    init(view: AboutViewProtocol, router: RouterProtocol?)
    
    func popToRootViewCOntroller()
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class AboutPresenter: AboutViewPresenterProtocol {
    
    weak var view: AboutViewProtocol?
    var router: RouterProtocol?
    
    required init(view: AboutViewProtocol, router: RouterProtocol?) {
        self.view = view
        self.router = router
        
    }
    
    func popToRootViewCOntroller() {
        router?.popToRoot()
    }
}
