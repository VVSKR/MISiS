//
//  ModuleBuilder.swift
//  MISiS
//
//  Created by Vova SKR on 05.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createAuthModule(router: RouterProtocol) -> UIViewController
    func createScheduleModule(schedule: [LessonModel], router: RouterProtocol) -> UIViewController
    func createCampusModule() -> UIViewController
    func createInfoModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createAuthModule(router: RouterProtocol) -> UIViewController {
        let view = AuthViewController()
        let networkManager = NetworkManager()
        let presenter = AuthPresentor(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
    
    func createScheduleModule(schedule: [LessonModel], router: RouterProtocol) -> UIViewController {
        let view = ScheduleViewController()
        let presenter = SchedulePresenter(view: view, schedule: schedule, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCampusModule() -> UIViewController {
        let view = CampusViewController()
        let presenter = CampusPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createInfoModule(router: RouterProtocol) -> UIViewController {
        let view = AboutViewController()
        let presenter = AboutPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
