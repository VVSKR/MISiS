//
//  ScheduleViewController.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var presenter: ScheduleViewPresenterProtocol?
    
    private lazy var safeArea = view.safeAreaLayoutGuide
    
    var segmentControll: CustomSegmentedControl!
    var collectionView: UICollectionView!
    
    var dateField: UITextField!
    var datePicker: UIDatePicker!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        setSegmentControll()
        setCollectionView()
        setDatePicker()
        setTapGesture()
        setNavBar()
    }
    
    @objc func rightButtonPressed() {
        let alert = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        let doneAction = UIAlertAction(title: "Выбрать", style: .cancel) { (_) in
            self.doneActionFunc()
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
      
//        alert.addAction(title: "Done", style: .cancel)
//        dateField.becomeFirstResponder()
    }
    
    
}

// MARK: - Setup view
private extension ScheduleViewController {
    
    private func setNavBar() {
        let calendarImage = UIImage(named: "calendar")
        let rightBarItem = UIBarButtonItem(image: calendarImage, style: .done, target: self, action: #selector(rightButtonPressed))
    
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
        navigationController?.setClearBackground()
        
        navigationController?.setTitleFont()
    }
    
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
        let flowLayout = CenteredFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
        
        collectionView.backgroundColor = .white

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.reuseID)
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 2),
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
        dateField.frame = CGRect(x: 0, y: 45, width: 270, height: 200)
        datePicker.center.x = view.center.x
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        let loc = Locale(identifier: "ru")
//        let localID = Locale.preferredLanguages.first
        datePicker.locale = loc
        
        setPickerToolBar()
    }
    
    func setPickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionFunc))
        let todayButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(doneActionFunc))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([todayButton, flexSpace, doneButton], animated: true)
        dateField.inputAccessoryView = toolBar
    }
    
    @objc
    func doneActionFunc() {
        // следующая неделя
//        let currentDate = datePicker.date
//        datePicker.date = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)! //
        presenter?.setTitle(for: datePicker.date)
        presenter?.setCurrentWeek(for: datePicker.date)
        reloadCollectionView()
        view.endEditing(true)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseID, for: indexPath) as? ScheduleCell else {
            return UICollectionViewCell()
        }
        
        presenter?.setDataSourse(cell, indexPath: indexPath.row)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.frame.width,
//                      height: collectionView.frame.height)
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        presenter.setSegmentPosition()
    }
    
    
}


// MARK: - Protocol extension
extension ScheduleViewController: ScheduleViewProtocol {
    
    func setTitle(_ title: String?) {
        navigationItem.title = title
    }
    
    func currentPosition() -> CGFloat {
        return collectionView.contentOffset.x / view.frame.width // можно перенести логику в презентор
    }
    
    func setPositionSegmentControll(position: CGFloat) {
        segmentControll.setIndex(position: position)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension ScheduleViewController: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
    }
}



