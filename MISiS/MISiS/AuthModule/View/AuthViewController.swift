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
    
    private let logoImageView = UIImageView(image: UIImage(named: "misisLogo"))
    private let backgroundImage = UIImageView(image: UIImage(named: ""))
    private let greetingsLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var selectInstitutionButton = CustomSizedButton()
    private var groupTextField = CustomSizedTextField()
    
    private var tableView = UITableView()
    private var continueButton = ButtonWithActivityIndicator()
    private var bottomList: BottomListView!
    
    private lazy var continueButtonYConstraint = continueButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    private lazy var safeArea = view.safeAreaLayoutGuide
    
    private let heightElement: CGFloat = 50
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "misis1")!)
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "misis1")
//        backgroundImage.contentMode = .scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        if UserDefaults.standard.returmGroup() != "" , UserDefaults.standard.returnUnstitute() != "", let schedule = UserDefaults.standard.returnSchedule() {
            print(schedule)
            presenter.scheduleModel = schedule
            presenter.pushToTabBar()
        }
        setLogo()
        setGreetingsLabel()
        setSubTitleLabel()
        
        //        setInstitutionTextField()
        setSelectInstitutionButton()
        setCourseTextField()
        
        setTableView()
        setContinueButton()
        setGestureRecognizer()
        
    }
}

// MARK: - Setting views

private extension AuthViewController {
    
    
    func setLogo() {
        logoImageView.contentMode = .scaleAspectFit
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            logoImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.75),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1/2),
            logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    //MARK:  Label
    func setGreetingsLabel() {
        greetingsLabel.text = "Вход"
        greetingsLabel.font = UIFont.boldSystemFont(ofSize: 30)
        greetingsLabel.textAlignment = .left
        greetingsLabel.numberOfLines = 1
        
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingsLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            greetingsLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            greetingsLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            greetingsLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func setSubTitleLabel() {
        subtitleLabel.text = "Выберите институт и группу"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 1
        
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: greetingsLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: greetingsLabel.leadingAnchor, constant: 0),
            subtitleLabel.trailingAnchor.constraint(equalTo: greetingsLabel.trailingAnchor, constant: 0),
        ])
    }
    // MARK: - Text Field
    func setSelectInstitutionButton() {
//
        selectInstitutionButton.setTitle("Выберите институт", for: .normal)
        selectInstitutionButton.titleLabel?.font = .systemFont(ofSize: 17)
        selectInstitutionButton.setTitleColor(UIColor.gray.withAlphaComponent(0.55), for: .normal)
        selectInstitutionButton.contentHorizontalAlignment = .left
        
        selectInstitutionButton.addTarget(self, action: #selector(tapInstitutionSelectButton), for: .touchUpInside)
        
        selectInstitutionButton.layer.borderWidth = 1
        selectInstitutionButton.layer.borderColor = UserColor.mainBlue.cgColor
        selectInstitutionButton.layer.cornerRadius = 8
//        selectInstitutionButton.addSeparator(at: .bottom, color: .lightBlue, weight: 1)
        
        view.addSubview(selectInstitutionButton)
        selectInstitutionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectInstitutionButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            selectInstitutionButton.leadingAnchor.constraint(equalTo: greetingsLabel.leadingAnchor, constant: 0),
            selectInstitutionButton.trailingAnchor.constraint(equalTo: greetingsLabel.trailingAnchor, constant: 0),
            selectInstitutionButton.heightAnchor.constraint(equalToConstant: heightElement)
        ])
    }
    
    
    func setCourseTextField() {
      
        groupTextField.backgroundColor = .clear
        
        groupTextField.borderStyle = .none
        groupTextField.placeholder = "Введите группу, например: БПИ-16-2"
        groupTextField.tintColor = .black
        
//        groupTextField.addSeparator(at: .bottom, color: .lightBlue, weight: 1)
        groupTextField.layer.borderWidth = 1
        groupTextField.layer.borderColor = UserColor.mainBlue.cgColor
        groupTextField.layer.cornerRadius = 8
//        groupTextField.font = Fonts.bodyFont
        groupTextField.returnKeyType = .continue
        groupTextField.autocorrectionType = .no
        groupTextField.text = "БПИ-16-2"

        view.addSubview(groupTextField)
        groupTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupTextField.topAnchor.constraint(equalTo: selectInstitutionButton.bottomAnchor, constant: 15),
            groupTextField.leadingAnchor.constraint(equalTo: greetingsLabel.leadingAnchor, constant: 0),
            groupTextField.trailingAnchor.constraint(equalTo: greetingsLabel.trailingAnchor, constant: 0),
            groupTextField.heightAnchor.constraint(equalToConstant: heightElement)
        ])
    }
    
    
    // MARK: - Table view (delete)
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
            tableView.topAnchor.constraint(equalTo: groupTextField.bottomAnchor, constant: 22),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setContinueButton() {
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        continueButton.backgroundColor = UserColor.mainBlue
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        continueButtonYConstraint.constant = -16
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: groupTextField.bottomAnchor, constant: 25),
            continueButton.heightAnchor.constraint(equalToConstant: heightElement),
            continueButton.leadingAnchor.constraint(equalTo: greetingsLabel.leadingAnchor, constant: 0),
            continueButton.trailingAnchor.constraint(equalTo: greetingsLabel.trailingAnchor, constant: 0),
        ])
        
        continueButton.configure()
    }
    
    // MARK: - Tap Gesture
    func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandle(tap:)))
        tap.cancelsTouchesInView = false
        self.continueButton.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tapGestureHandle(tap: UITapGestureRecognizer) {
        guard view.hitTest(tap.location(in: self.view), with: nil) as? UIButton == nil else { return }
        view.endEditing(true)
    }
    
    @objc func tapInstitutionSelectButton() {
        view.endEditing(true)
        bottomList = BottomListView(frame: view.frame)
        let images = [UIImage(named: "itasy"), UIImage(named: "ibo"), UIImage(named: "inmin"), UIImage(named: "mgi"), UIImage(named: "eypp"), UIImage(named: "ecotex"), UIImage(named: "iibs")]
        bottomList.set(list: ["ИТАСУ", "ИБО", "ИНМиН", "МГИ", "ЭУПП", "ЭкоТех", "ИИБС"], images: images, textAligment: .left)
        bottomList.delegate = self
        view.addSubview(bottomList)
    }
    
    
    // MARK: - Continue Button
    @objc func continueButtonPressed() {
        continueButton.startActivity()
        presenter.isDataValid(institutionName: selectInstitutionButton.titleLabel!.text!,
                              groupName: groupTextField.text)
//        presenter.pushToTabBar()
    }
    
    func setCourse() {
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
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
        continueButton.stopActivity()
        UserDefaults.standard.setGroup(institute: selectInstitutionButton.titleLabel?.text, group: groupTextField.text)
        presenter.pushToTabBar()
    }
    
    func failureResponce() { // вызвать какой алерт и сообщать об ошибке
        continueButton.stopActivity()
        showAlert(title: "Упс...", message: "Что-то пошло не так. Попробуйте позже или свяжитесь с нами и мы решим вашу проблему")
    }
    
    func emptyResponce() { // вызвать какой алерт и говорить, что массив с распинием пустой
        continueButton.stopActivity()
        showAlert(title: "Упс...", message: "Мы не нашли расписание для этой группы. Проверьте корректность введенных данных или свяжитесь с нами.")
    }
    
    func changeInstiotutionText(_ institution: String) {
        selectInstitutionButton.setTitle(institution, for: .normal)
        selectInstitutionButton.setTitleColor(.black, for: .normal)
    }
    
    func shakeInstitution() {
        continueButton.stopActivity()
        selectInstitutionButton.shake()
    }
    
    func shakeGroup() {
        continueButton.stopActivity()
        groupTextField.shake()
    }
    
}
 // MARK: - BottomListViewDelegate
extension AuthViewController: BottomListViewDelegate {
    func selectRow(item: String) {
        presenter.setInstitution(item)
    }
    
    func dissmissList() {
        bottomList.removeFromSuperview()
    }
}






