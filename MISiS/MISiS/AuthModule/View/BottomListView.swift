//
//  BottomListView.swift
//  MISiS
//
//  Created by Vova SKR on 27.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

protocol BottomListViewDelegate: AnyObject {
    func dissmissList()
    func selectRow(item: String)
}

class BottomListView: UIView {
    
    var tableView: UITableView!
    var tableViewTopConstraint: NSLayoutConstraint!
    var list: [String] = []
    var textAligment: NSTextAlignment = .left
    weak var delegate: BottomListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(list: [String], textAligment: NSTextAlignment = .left) {
        self.list = list
        self.textAligment = textAligment
        setupTableView()
        setupGestureTap()
        showAnimated()
    }
    
    
    @objc func tapGestureHandle(tap: UITapGestureRecognizer) {
        guard self.hitTest(tap.location(in: self), with: nil) as? BottomListView != nil else { return }
        dissmiss()
    }
    
    
    func dissmiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.tableViewTopConstraint.constant = 0
            self.layoutIfNeeded()
        }) { (_) in
            self.delegate?.dissmissList()
        }
    }
    
    
    func showAnimated() {
        let bottomPadding: CGFloat = 50
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.2
        }) { (_) in
            self.tableViewTopConstraint.constant = -self.tableView.contentSize.height - bottomPadding
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: - TableView Delegate
extension BottomListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = textAligment
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectRow(item: list[indexPath.row])
        dissmiss()
    }
}


// MARK: - Setup View
private extension BottomListView {
    func setupView() {
        self.alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .none
        
        
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .black
        self.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.layoutIfNeeded()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableViewTopConstraint,
            tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
        ])
    }
    
    func setupGestureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandle(tap:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
        self.addGestureRecognizer(tap)
        
    }
}


