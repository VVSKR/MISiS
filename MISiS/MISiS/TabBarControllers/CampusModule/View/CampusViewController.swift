//
//  CampusViewController.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class CampusViewController: UIViewController {

    var presenter: CampusViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}

extension CampusViewController: CampusViewProtocol{
    
}
