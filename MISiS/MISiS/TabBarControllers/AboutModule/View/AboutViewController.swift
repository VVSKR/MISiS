//
//  AboutViewController.swift
//  MISiS
//
//  Created by Vova SKR on 06.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit
import MessageUI

struct InfoAction { // создать файл модель
    let title: String
    let icon: UIImage?
    let action: () -> Void
}


class AboutViewController: UIViewController {
    
    var presenter: AboutPresenter?
    
    private lazy var actions = [ // в презентер
        InfoAction(title: "Официальный сайт НИТУ МИСиС",
                   icon: UIImage(named: "misisMiniLogo"),
                   action: showUniversityWebsite),
        InfoAction(title: "Поделиться приложением",
                   icon: UIImage(named: "share"),
                   action: shareApp),
        InfoAction(title: "Обратная связь",
                   icon: UIImage(named: "send"),
                   action: showMailComproser)
    ]
    
    private var tableView = UITableView()
    
    private var currentGroupCell: CurrentGroupCell?
    
    private var webSiteLabel: ButtonWithIcon?
    private var shareButton: ButtonWithIcon?

    private var feedBackLabel: ButtonWithIcon?
    private var releaseVersionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "О приложении"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = UserColor.gray5
        setupTableView()

        setReleaseVersionLabel()
//        setupWebSiteLabel()
//        setupShareButton()
//        setupFeedBackButton()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UserColor.gray5
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.customTableViewCellIndentifire)
        tableView.register(CurrentGroupCell.self, forCellReuseIdentifier: CurrentGroupCell.customTableViewCellIndentifire)
        let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
        firstCell?.selectionStyle = .none

        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = view.safeAreaLayoutGuide
        tableView.leadingAnchor.constraint(equalTo: layout.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layout.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
    }
    
    private func setReleaseVersionLabel() {
        releaseVersionLabel.textAlignment = .center
        releaseVersionLabel.numberOfLines = 1
        releaseVersionLabel.tintColor = .black
        releaseVersionLabel.text = "Версия 1.0.0"

        releaseVersionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        view.insertSubview(releaseVersionLabel, at: 1)
        releaseVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseVersionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        releaseVersionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        releaseVersionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    
    private func showUniversityWebsite() {
        if let url = URL(string: "https://misis.ru") {
            UIApplication.shared.open(url)
        }
    }
    
    private func shareApp() {
        let items = ["Расписание занятий НИТУ МИСиС"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func showMailComproser() {
        guard MFMailComposeViewController.canSendMail() else { sendMailViaMailTo() ; return }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([Constants.appMail])
        present(composer, animated: true)
    }
    
    private func sendMailViaMailTo() {
        if let url = URL(string: "mailto:\(Constants.appMail)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension AboutViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentGroupCell.customTableViewCellIndentifire, for: indexPath) as! CurrentGroupCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellIndentifire, for: indexPath) as! CustomTableViewCell
            cell.backgroundColor = .clear
            
            let action = infoItem(row: indexPath.row - 1)
            cell.set(text: action?.title, image: action?.icon)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
        infoItem(row: indexPath.row - 1)?.action()
        }
    }
    
    private func infoItem(row: Int) -> InfoAction? {
        guard row < actions.count else { return nil }
        return actions[row]
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension AboutViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}



private extension AboutViewController {
    enum Constants {
        
        static let appMail = "vova.skri.dev@gmail.com"
        
    }
}

extension AboutViewController: AboutViewProtocol {
    
}

extension AboutViewController: CurrentGroupCellDelegate {
    
    func exitButtonTap() {
        UserDefaults.standard.deleteShedule()
        presenter?.popToRootViewCOntroller()
    }
}


