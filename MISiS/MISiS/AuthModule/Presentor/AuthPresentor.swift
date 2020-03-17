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
    
    func shakeGroup()
    func shakeInstitution()
    
    func changeInstiotutionText(_ institution: String)
    
    // функции которые должны срабатывть в view
    
}

protocol AuthViewPresenterProtocol: class { // подписывается presentor
    init(view: AuthViewProtocol, networkManager: NetworkManager, router: RouterProtocol)
    
    var scheduleModel: ScheduleModel? { get set }
    
    func addKeyboardNotifications()
    func pushToTabBar()
    func getSchedule(requestModel: ScheduleRequestModel)
    func isDataValid(institutionName: String, groupName: String?)
    
    func setInstitution(_ institution: String) 
    
    // функции которые вызываются в view чтобы сработада бизнес логика
}


class AuthPresentor: AuthViewPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManager
    var scheduleModel: ScheduleModel?
    var scheduleRequestModel: ScheduleRequestModel?
    
    var isBachelor: Bool = true // бакалавр или нет
    
    required init(view: AuthViewProtocol, networkManager: NetworkManager, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        addKeyboardNotifications()
    }
    func getSchedule(requestModel: ScheduleRequestModel) {
        networkManager.getSchedule(institution: requestModel.institution, year: requestModel.year, group: requestModel.group, subGroup: requestModel.subgroup) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedule):
                    guard schedule.success,schedule.schedule.count != 0 else { self?.view?.shakeGroup(); return }
                    self?.scheduleModel = schedule
                    self?.view?.successResponce()
                case .failure(_):
                    self?.view?.failureResponce()
                }
            }
        }
    }
    
    func pushToTabBar() { // запрос к апи сделать
        router?.pushToMainTabBar(schedule: scheduleModel?.schedule ?? [])
    }
    
    // MARK: - KeyBoard Notifications
    
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
    
    // MARK: - Data validation
    
    func isDataValid(institutionName: String, groupName: String?) { // переименовать
        guard institutionName.count < 10 else { view?.shakeInstitution(); return }
        guard let groupName = groupName, checkGroupNameValid(text: groupName),
            let year = setCourse(groupName: groupName) else { view?.shakeGroup(); return }
        let scheduleRequest = ScheduleRequestModel(institution: institutionName, year: year, group: groupName, subgroup: 1)
        print(scheduleRequest)
            // вызывать анимацию загрузки в view и после анимации вызывать getSchedule
        getSchedule(requestModel: scheduleRequest)
        
    }
    
    private func setCourse(groupName: String) -> String? {
        print(groupName)
        guard let groupString = groupName.slice(from: "-", to: "-") else { return nil  }
        print(groupString)
        guard let groupInt = Int(groupString) else { return nil }
        if isBachelor {
            let group = CourseBachelor(rawValue: groupInt)
            return group?.group
        } else {
            let group = CourseMaga(rawValue: groupInt)
            return group?.group
        }
    }
    
    
    private func checkGroupNameValid(text: String?) -> Bool {
        guard let text = text else { return false }
        let stringComponents = text.components(separatedBy: "-")
        let validComponents = stringComponents.filter { $0.isEmpty }.isEmpty
        guard stringComponents.count >= 3, validComponents else { return false }
        
        for char in stringComponents[0] {
            guard char.isLetter else { return false }
        }
        
        for firstNumber in stringComponents[1] {
            guard firstNumber.isNumber else { return false }
        }
        
        for secondNumber in stringComponents[2] {
            guard secondNumber.isNumber else { return false }
        }
        
        return true
    }
    
    // MARK: - set institution
    
    func setInstitution(_ institution: String) {
        view?.changeInstiotutionText(institution)
    }
}

