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
    func createScheduleModule(router: RouterProtocol) -> UIViewController
    func createCampusModule() -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createAuthModule(router: RouterProtocol) -> UIViewController {
        let view = AuthViewController()
        let presenter = AuthPresentor(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    func createScheduleModule(router: RouterProtocol) -> UIViewController {
        let view = ScheduleViewController()
        let presenter = SchedulePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCampusModule() -> UIViewController {
        let view = CampusViewController()
        let presenter = CampusPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    
  
    
    
}
