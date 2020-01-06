//
//  ScheduleViewController.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var presenter: ScheduleViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }
    
}

extension ScheduleViewController: ScheduleViewProtocol {
    
}
