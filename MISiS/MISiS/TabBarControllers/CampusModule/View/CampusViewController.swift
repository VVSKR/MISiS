//
//  CampusViewController.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit
import MapKit

class CampusViewController: UIViewController {
    
    var presenter: CampusViewPresenterProtocol!
    
    var currentAnnotation = MKPointAnnotation()
    let tilesOverlay = DGSTileOverlay()
//    lazy var locationManager = UserLocation()
    private lazy var layout = view.safeAreaLayoutGuide
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
       
    }
    
    func setMapView() {
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: layout.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: layout.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: layout.bottomAnchor)
        ])
    }
    
    
    
}

extension CampusViewController: CampusViewProtocol{
    
}
