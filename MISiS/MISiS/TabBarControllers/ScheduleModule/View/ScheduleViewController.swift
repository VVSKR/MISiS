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
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setSegmentControll()
        setCollectionView()
        segmentControll.delegate = self // перенести в презентор
        title = Date().makeTitle()
        // Do any additional setup after loading the view.
        let index = Date.getIndexOfDayForSegmented()
        UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
               self.collectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .right, animated: true)
        })
          
        
        let rightBarItem = UIBarButtonItem(title: "Hi", style: .done, target: self, action: #selector(rightButtonPressed))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightButtonPressed() {
         let index = Date.getIndexOfDayForSegmented()
         collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
    }
}


private extension ScheduleViewController {
    
    func setSegmentControll() {
        segmentControll = CustomSegmentedControl()
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
}

// MARK: - CollectionView Delegate, DataSourse
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseID, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        
        cell.dataSource = ScheduleDataSource(day: Day.thursday, lessons: [LessonInfo(time: "11-11", subject: "Subject", type: "Type", place: "Place", groups: "Group", teacher: "Teatcher")], days: "3", month: 1)
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



