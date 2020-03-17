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
    var campusButton = UIButton()
    private var bottomList: BottomListView!
    
    private lazy var layout = view.safeAreaLayoutGuide
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
        setCampusButton()
//        mapView.max
    }
    
    func setMapView() {
        title =  "Карта корпусов"
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.insertOverlay(tilesOverlay, at: 0, level: .aboveLabels)
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 55.7282, longitude: 37.6089)
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: layout.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: layout.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: layout.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: layout.bottomAnchor)
        ])
    }
    
    func setCampusButton() {
        campusButton.setTitle("Выбрать корпус", for: .normal)
        campusButton.setTitleColor(.systemBlue, for: .normal)
        campusButton.addTarget(self, action: #selector(campusButtonPressed), for: .touchUpInside)
       
        campusButton.backgroundColor = .white
        view.addSubview(campusButton)
        campusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            campusButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            campusButton.widthAnchor.constraint(equalTo: layout.widthAnchor, multiplier: 0.8),
            campusButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20),
            campusButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor)
        ])
        campusButton.layoutIfNeeded()
        campusButton.configure()
    }
    
    @objc
    func campusButtonPressed() {
        bottomList = BottomListView(frame: UIScreen.main.bounds)
        bottomList.set(list: CampusData.campus.keys.sorted(), textAligment: .center)
        bottomList.delegate = self
        UIApplication.shared.keyWindow?.addSubview(bottomList)
    }
}

extension CampusViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
}

extension CampusViewController: CampusViewProtocol{
    
}


extension CampusViewController: BottomListViewDelegate {
    func selectRow(item: String) {
//        presenter.setInstitution(item)
    }
    
    func dissmissList() {
        bottomList.removeFromSuperview()
    }
}
