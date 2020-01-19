//
//  AuthPresentor.swift
//  MISiS
//
//  Created by Vova SKR on 05.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol AuthViewProtocol: class { // подписвается view
    func showKeyBoard(keyboardHeight: CGFloat)
    func hideKeyBoard()
    
    func successResponce()
    func failureResponce()
    func emptyResponce()
    // функции которые должны срабатывть в view
    // видимо надо прям все сюда закидывать
}

protocol AuthViewPresenterProtocol: class { // подписывается presentor
    init(view: AuthViewProtocol, networkManager: NetworkManager, router: RouterProtocol)
    
    var scheduleModel: ScheduleModel? { get set }
    
    func addKeyboardNotifications()
    func pushToTabBar()
    // тут можно передать сами данные, делать запрос в сеть, дожидаться данные и только потом переходить на следующий экран или прост сразу переходить на след экран и там уэе делать запрос в сеть
    
    func getSchedule(institution: String, year: String, group: String, subGroup: Int)
    
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class AuthPresentor: AuthViewPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManager
    var scheduleModel: ScheduleModel? = ScheduleModel(dto: ScheduleModelDTO(success: true, schedule: nil))
    
    required init(view: AuthViewProtocol, networkManager: NetworkManager, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }
    
    func getSchedule(institution: String, year: String, group: String, subGroup: Int) {
        networkManager.getEvents(institution: institution, year: year, group: group, subGroup: subGroup) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedule):
                    guard schedule.success else { self?.view?.emptyResponce(); return }
                    self?.scheduleModel = schedule
                    self?.view?.successResponce()
                case .failure(_):
                    self?.view?.failureResponce()
                }
            }
        }
    }
    
    
    
    func pushToTabBar() { // запрос к апи сделать
        router?.pushToMainTabBar(schedule: scheduleModel!.schedule)
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
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
