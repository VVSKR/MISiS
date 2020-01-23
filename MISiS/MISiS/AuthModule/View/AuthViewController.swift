//
//  AuthViewController.swift
//  MISiS
//
//  Created by Vova SKR on 05.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    public var presenter: AuthViewPresenterProtocol!
    
    private let logoImageView = UIImageView(image: UIImage(named: "mpei_short_logo"))
    private let greetingsLabel = UILabel()
    private var institutionTextField = UITextField()
    private var groupTextField = UITextField()
    
    private var tableView = UITableView()
    private var continueButton = UIButton()
    
    private lazy var continueButtonYConstraint = continueButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    private lazy var safeArea = view.safeAreaLayoutGuide
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLogo()
        setGreetingsLabel()
        
        setInstitutionTextField()
        setCourseTextField()
        
        setTableView()
        setContinueButton()
        
        presenter.addKeyboardNotifications()
    }
}

// MARK: - Setting views

private extension AuthViewController {
    
    
    func setLogo() {
        logoImageView.contentMode = .scaleAspectFit
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.75),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1/3),
            logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    // Label
    func setGreetingsLabel() {
        greetingsLabel.text = "Добро пожаловать!"
        greetingsLabel.font = UIFont.boldSystemFont(ofSize: 24)
        greetingsLabel.textAlignment = .center
        greetingsLabel.numberOfLines = 1
        
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingsLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            greetingsLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 36),
            greetingsLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -36),
            greetingsLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func setCourseTextField() {
        groupTextField.placeholder = "Введите группу, например: БПИ-16-2"
        groupTextField.textAlignment = .left
//        groupTextField.keyboardType = .numberPad
        //        groupField.delegate = self
        
        groupTextField.borderStyle = .roundedRect
        groupTextField.returnKeyType = .continue
        groupTextField.autocorrectionType = .no
        
        view.addSubview(groupTextField)
        groupTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupTextField.topAnchor.constraint(equalTo: institutionTextField.bottomAnchor, constant: 16),
            groupTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            groupTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            groupTextField.heightAnchor.constraint(equalToConstant: 54),
            groupTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        
    }
    
    func setInstitutionTextField() {
           institutionTextField.placeholder = "Введите институт, например: ИТАСУ"
           institutionTextField.textAlignment = .left
           //        groupField.delegate = self
           
           institutionTextField.borderStyle = .roundedRect
           institutionTextField.returnKeyType = .continue
           institutionTextField.autocorrectionType = .no
           
           view.addSubview(institutionTextField)
           institutionTextField.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               institutionTextField.topAnchor.constraint(equalTo: greetingsLabel.bottomAnchor, constant: 16),
               institutionTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
               institutionTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
               institutionTextField.heightAnchor.constraint(equalToConstant: 54),
               institutionTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
           ])
           
           
       }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        //        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: institutionTextField.bottomAnchor, constant: 22),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setContinueButton() {
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.systemBlue, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        continueButton.backgroundColor = .white
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        continueButtonYConstraint.constant = -16
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            continueButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8),
            continueButtonYConstraint,
            continueButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        continueButton.layoutIfNeeded()
        continueButton.configure()
    }
    
    
    // MARK: - URL session
    @objc
    func continueButtonPressed() {
        print("Responce")
        presenter.isDataValid(institutionName: institutionTextField.text, groupName: groupTextField.text)
        
        

//        presenter.getSchedule(requestModel: ScheduleRequestModel(institution: "ИТАСУ", year: "4 курс", group: "БПИ-16-2", subgroup: 1))
    }
    
    func setCourse() {
        
    }
   
}

// MARK: - TableView Delegate , DataSourse

extension AuthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}


// MARK: - AuthView Protocol
extension AuthViewController: AuthViewProtocol {
    
    
    
    func showKeyBoard(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.continueButtonYConstraint.constant = -keyboardHeight - 16
            self.tableView.alpha = 0
            self.view.layoutIfNeeded()
        }
        tableView.isUserInteractionEnabled = false
    }
    
    func hideKeyBoard() {
        UIView.animate(withDuration: 0.3) {
            self.continueButtonYConstraint.constant = -16
            self.tableView.alpha = 1
            self.view.layoutIfNeeded()
        }
        tableView.isUserInteractionEnabled = true
    }
    
    func successResponce() { // не уверен, что этот запрос нужен
        print("SUCCESS")
        // останавливать анимацию загрузки
        presenter.pushToTabBar()
    }
    
    func failureResponce() { // вызвать какой алерт и сообщать об ошибке
        print("FAIL")
    }
    
    func emptyResponce() { // вызвать какой алерт и говорить, что массив с распинием пустой
        
    }
    
    func shakeInstitution() {
        institutionTextField.shake()
    }
    
    func shakeGroup() {
        groupTextField.shake()
    }
    
}






