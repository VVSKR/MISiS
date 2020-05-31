//
//  Router.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func pushToMainTabBar(schedule: [LessonModel])
    func popToRoot()
}

// MARK: Class
class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createAuthModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
            navigationController.isNavigationBarHidden = true
        }
    }
    
    func pushToMainTabBar(schedule: [LessonModel]) {
        if let navigationController = navigationController {
            let tabBarController = UITabBarController()
            guard let assemblyBuilder = assemblyBuilder else { return }
            let scheduleViewController = assemblyBuilder.createScheduleModule(schedule: schedule, router: self)
            let campusViewController = UINavigationController(rootViewController: assemblyBuilder.createCampusModule())
            let infoViewController = UINavigationController(rootViewController: assemblyBuilder.createInfoModule(router: self))
            
            
            tabBarController.viewControllers = [UINavigationController(rootViewController: scheduleViewController), campusViewController, infoViewController]
            
            tabBarController.tabBar.items?[0].title = "Расписание"
            tabBarController.tabBar.items?[0].image = UIImage(named: "list")
            
            tabBarController.tabBar.items?[1].title = "Карта корпусов"
            tabBarController.tabBar.items?[1].image = UIImage(named: "location")
            
            tabBarController.tabBar.items?[2].title = "О приложении"
            tabBarController.tabBar.items?[2].image = UIImage(named: "info")
            
            navigationController.pushViewController(tabBarController, animated: true)
        }
    }
    
    func popToRootViewController() {
        
    }
    
    
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
