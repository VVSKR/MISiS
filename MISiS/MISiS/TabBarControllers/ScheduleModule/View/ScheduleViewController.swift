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
    
    private lazy var safeArea = view.safeAreaLayoutGuide
    
    var segmentControll: CustomSegmentedControl!
    var collectionView: UICollectionView!
    
    var dateField: UITextField!
    var datePicker: UIDatePicker!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setSegmentControll()
        setCollectionView()
        setDatePicker()
        setTapGesture()
//        presenter.setCurrentWeek(for: Date()) // возможно то надо переносить в презентов, но хз
        title = Date().makeTitle() // перенести в презентор
    
          
        
        let rightBarItem = UIBarButtonItem(title: "Hi", style: .done, target: self, action: #selector(rightButtonPressed))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightButtonPressed() {
//         let index = Date.getIndexOfDayForSegmented() // перенести в презентор
//         collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
        dateField.becomeFirstResponder()
    }
}

// MARK: - Setup view
private extension ScheduleViewController {
    
    func setSegmentControll() {
        segmentControll = CustomSegmentedControl()
        segmentControll.delegate = self
        segmentControll.setButtonTitles(buttonTitles: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб"])
        
        segmentControll.backgroundColor = .clear
        view.addSubview(segmentControll)
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControll.topAnchor.constraint(equalTo: safeArea.topAnchor),
            segmentControll.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            segmentControll.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            segmentControll.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setCollectionView() {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.reuseID)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentControll.bottomAnchor, constant: 2),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    // MARK: - Date Picker
    func setDatePicker() {
        dateField = UITextField(frame: .zero)
        view.addSubview(dateField)
        datePicker = UIDatePicker()
        dateField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        let localID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localID!)
        
        setPickerToolBar()
    }
    
    func setPickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let todayButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([todayButton, flexSpace, doneButton], animated: true)
        dateField.inputAccessoryView = toolBar
    }
    
    @objc
    func doneAction() {
        let currentDate = datePicker.date
        datePicker.date = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
//        view.endEditing(true)
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHundle))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tapGestureHundle() {
        view.endEditing(true)
    }
}

// MARK: - CollectionView Delegate, DataSourse
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // надо какой-то патерн замутить, так нельхя оставлять
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseID, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        presenter.setDataSourse(cell)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.setSegmentPosition()
    }
    
    
}


// MARK: - Protocol extension
extension ScheduleViewController: ScheduleViewProtocol {
    
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func currentPosition() -> CGFloat {
        return collectionView.contentOffset.x / view.frame.width // можно перенести логику в презентор
    }
    
    func setPositionSegmentControll(position: CGFloat) {
        segmentControll.setIndex(position: position)
    }
    
    
    
    
}

extension ScheduleViewController: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
    }
}



