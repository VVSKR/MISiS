//
//  AuthPresentor.swift
//  MISiS
//
//  Created by Vova SKR on 05.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol AuthViewProtocol: class { // подписвается view
    func setGreeting()
    func showKeyBoard(keyboardHeight: CGFloat)
    func hideKeyBoard()
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol AuthViewPresenterProtocol: class { // подписывается presentor
    init(view: AuthViewProtocol, router: RouterProtocol)
    func showGreeting()
    func addKeyboardNotifications()
    func tapOnTheButton() // тут можно передать сами данные, делать запрос в сеть, дожидаться данные и только потом переходить на следующий экран или прост сразу переходить на след экран и там уэе делать запрос в сеть
    
    
    
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class AuthPresentor: AuthViewPresenterProtocol {
    
    
    weak var view: AuthViewProtocol?
    var router: RouterProtocol?
    
    required init(view: AuthViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showGreeting() {
        view?.setGreeting()
    }
    
    func tapOnTheButton() {
        router?.pushToMainTabBar()
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHandle),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHandle),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil
        )
    }
    
    @objc
    func keyboardHandle(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if notification.name == UIResponder.keyboardWillHideNotification {
                view?.hideKeyBoard()
            } else {
                view?.showKeyBoard(keyboardHeight: keyboardHeight)
            }
            
        }
    }
}
