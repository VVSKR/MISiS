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
    
    var presenter: CampusViewPresenterProtocol?
    
    var currentAnnotation = MKPointAnnotation()
    let tilesOverlay = DGSTileOverlay()
    //    lazy var locationManager = UserLocation()
    var campusButton = UIButton()
    private var bottomList: BottomListView!
    
    private lazy var layout = view.safeAreaLayoutGuide
    
    var mapView = MKMapView()
    lazy var locationManager = UserLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
        setCampusButton()
//        mapView.max
        setupNavBar()
    }
    
    private func setupNavBar() { // попробовать сделать прозначный background 
        let calendarImage = UIImage(named: "navigation")
        let rightBarItem = UIBarButtonItem(image: calendarImage, style: .done, target: self, action: #selector(rightButtonPressed))
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
//        navigationController?.setClearBackground()
//        navigationController?.navigationBar.barTintColor = UIColor.white.withAlphaComponent(0.4)
//        navigationController?.setClearBackground()
    }
    
    @objc func rightButtonPressed() {
        locationManager.isEnabled.toggle()
        locationManager.requestWhenInUseAuthorization()

        if locationManager.isEnabled {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.image = UIImage(named: "navigationSelected")
            mapView.userTrackingMode = .follow
            mapView.userActivity?.becomeCurrent()
            mapView.showsUserLocation = true
        } else {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.image = UIImage(named: "navigation")
            mapView.userTrackingMode = .none
            mapView.userActivity?.invalidate()
            mapView.showsUserLocation = false
        }
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
        mapView.addAnnotation(currentAnnotation)
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: layout.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: layout.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setCampusButton() {
        campusButton.setTitle("Выбрать корпус", for: .normal)
        campusButton.setTitleColor(.white, for: .normal)
        campusButton.addTarget(self, action: #selector(campusButtonPressed), for: .touchUpInside)
       
        campusButton.backgroundColor = UserColor.mainBlue
        view.addSubview(campusButton)
        campusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            campusButton.heightAnchor.constraint(equalToConstant: 50),
            campusButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20),
            campusButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            campusButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 20)
        ])
        campusButton.layoutIfNeeded()
        campusButton.configure()
    }
    
    @objc func campusButtonPressed() {
        bottomList = BottomListView(frame: UIScreen.main.bounds)
        bottomList.set(list: CampusData.campus.keys.sorted(), images: nil, textAligment: .center)
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
        guard let campusLocation = CampusData.campus[item] else { return }
        UIView.animate(withDuration: 0.5, animations: {
            self.mapView.centerCoordinate = campusLocation
            self.currentAnnotation.coordinate = campusLocation
        })
    }
    
    func dissmissList() {
        bottomList.removeFromSuperview()
    }
}
