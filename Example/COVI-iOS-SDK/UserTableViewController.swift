//
//  ViewController.swift
//  COVI-iOS-SDK
//
//  Created by covi on 06/26/2024.
//  Copyright (c) 2024 covi. All rights reserved.
//

import UIKit
import covisdk
import os.log

class UserTableViewController: UITableViewController {
    var section: Int = 0
    var firstSectionData: [String] = []
    var secondSectionData: [String] = []
    var newTitleContent: String = ""
    var joinablePollCount = 16
    var shouldHideFirstSectionHeader = false
    let searchController = UISearchController()
    @IBOutlet weak var navigationItemView: UINavigationItem!

    var coviPlayer: CoviPlayer?
    var shouldShowCoviPlayer = false

    func configureRefreshcontrol() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRefreshcontrol()

        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: NSNotification.Name("AppDidEnterBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: NSNotification.Name("AppWillEnterForeground"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: NSNotification.Name("AppWillResignActive"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: NSNotification.Name("AppDidBecomeActive"), object: nil)

        self.tableView.showsVerticalScrollIndicator = false
//        setNavBarClickView()
        setTableData()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "[Toggle CoviPlayer]",
            style: .plain,
            target: self,
            action: #selector(toggleCoviPlayer)
        )
    }

    @objc func appDidEnterBackground() {
        print("appDidEnterBackground")

        coviPlayer?.onPauseCoviPlayer()
    }

    @objc func appWillEnterForeground() {
        print("appWillEnterForeground")
        
        coviPlayer?.onResumeCoviPlayer()
    }

    @objc func appWillResignActive() {
        print("appWillResignActive")

        coviPlayer?.onPauseCoviPlayer()
    }

    @objc func appDidBecomeActive() {
        print("appDidBecomeActive")

        coviPlayer?.onResumeCoviPlayer()
    }

    @objc func toggleCoviPlayer() {
        shouldShowCoviPlayer.toggle()
        if shouldShowCoviPlayer {
            coviPlayer = createCovi()
            coviPlayer?.appViewController = self
            coviPlayer?.loadContent(coviEventHandler: coviEventHandler)
        } else {
            destroyCovi()
        }
        
        tableView.reloadData()
    }

    func destroyCovi() {
        coviPlayer?.appViewController = nil
        coviPlayer = nil
    }

    func createCovi() -> CoviPlayer {
        let width = UIScreen.main.bounds.width
        let height = ceil(width / 1440.0 * 810.0)

        let coviPlayer = CoviPlayer(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
//        coviPlayer.translatesAutoresizingMaskIntoConstraints = false

        coviPlayer.type = "dev"
        coviPlayer.pcode = "hiclass_ios"
        coviPlayer.category = "hiclass"

        // 권장
        coviPlayer.age = 20
        coviPlayer.gender = "M"
        coviPlayer.idfa = "test-idfa-value"

        // 선택
        coviPlayer.playType = .auto_play
        coviPlayer.playerCornerRadius = 0

        return coviPlayer
    }

    deinit {
        // 옵저버 제거
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - 이벤트 핸들러 설정
    func coviEventHandler(event: String) {
        switch (event) {
        case "VAST_LOAD_SUCCESS":
            print("VAST_LOAD_SUCCESS")

        case "VAST_LOAD_FAIL":
            print("VAST_LOAD_FAIL")

        case "SDK_NO_ADS":
            print("no ads")

        case "PLAYER_LOAD_FAIL":
            print("PLAYER_LOAD_FAIL")

        case "PLAYER_VIDEO_PLAY":
            print("PLAYER_VIDEO_PLAY")

        case "PLAYER_VIDEO_PAUSE":
            print("PLAYER_VIDEO_PAUSE")

        case "PLAYER_VIDEO_REPLAY":
            print("PLAYER_VIDEO_REPLAY")

        case "PLAYER_VIDEO_ENDED":
            print("PLAYER_VIDEO_ENDED")

        default:
            break
        }
    }

    func setNavBarClickView() {
        let titleName = UILabel()
        titleName.text = "Sample App"
        titleName.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleName.textColor = .black
        titleName.textAlignment = .left
        titleName.sizeToFit()

        let titleInfo = UILabel()
        titleInfo.text = ""
        titleInfo.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleInfo.textColor = .black
        if #available(iOS 13.0, *) {
            titleInfo.backgroundColor = .systemGray6
        } else {
            titleInfo.backgroundColor = .lightGray
            // Fallback on earlier versions
        }
        titleInfo.textAlignment = .left
        titleInfo.sizeToFit()

        let stackView1 = UIStackView(arrangedSubviews: [titleName, titleInfo])
        stackView1.axis = .horizontal
        stackView1.distribution = .fillProportionally
        stackView1.alignment = .leading
        stackView1.spacing = 10

        let nav1 = UILabel()
        nav1.text = "tabBar1    |"
        nav1.font = UIFont.boldSystemFont(ofSize: 12)
        nav1.textColor = .black
        nav1.textAlignment = .left
        nav1.sizeToFit()

        let nav2 = UILabel()
        nav2.text = "tabBar2    |"
        nav2.font = UIFont.boldSystemFont(ofSize: 12)
        nav2.textColor = .black
        nav2.textAlignment = .left
        nav2.sizeToFit()

        let nav3 = UILabel()
        nav3.text = "tabBar3    |"
        nav3.font = UIFont.boldSystemFont(ofSize: 12)
        nav3.textColor = .black
        nav3.textAlignment = .left
        nav3.sizeToFit()

        let nav4 = UILabel()
        nav4.text = "tabBar4"
        nav4.font = UIFont.boldSystemFont(ofSize: 12)
        nav4.textColor = .black
        nav4.textAlignment = .left
        nav4.sizeToFit()

        let nav5 = UILabel()
        nav5.text = "                                          "
        nav5.font = UIFont.boldSystemFont(ofSize: 12)
        nav5.textColor = .black
        nav5.textAlignment = .left
        nav5.sizeToFit()

        let stackView2 = UIStackView(arrangedSubviews: [nav1, nav2, nav3, nav4, nav5])
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.alignment = .leading
        stackView2.spacing = 5

        let stackContainer1 = UIStackView(arrangedSubviews: [stackView1])
        stackContainer1.axis = .vertical
        stackContainer1.alignment = .leading
        stackContainer1.spacing = 10

        let stackContainer2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))

        let newStackContainer = UIStackView(arrangedSubviews: [stackContainer1, stackContainer2])
        newStackContainer.axis = .horizontal

        self.navigationItem.titleView = newStackContainer
    }

    func setTableData() {
        self.firstSectionData.append("1) Title content is here")
        self.firstSectionData.append("2) Title content is here")
        self.firstSectionData.append("3) Title content is here")
        self.firstSectionData.append("4) Title content is here")


        self.secondSectionData.append("1) Title content is here")
        self.secondSectionData.append("2) Title content is here")
        self.secondSectionData.append("3) Title content is here")
        self.secondSectionData.append("4) Title content is here")
        self.secondSectionData.append("5) Title content is here")
        self.secondSectionData.append("6) Title content is here")
        self.secondSectionData.append("7) Title content is here")
        self.secondSectionData.append("8) Title content is here")
        self.secondSectionData.append("9) Title content is here")
        self.secondSectionData.append("10) Title content is here")
        self.secondSectionData.append("11) Title content is here")
        self.secondSectionData.append("12) Title content is here")
        self.secondSectionData.append("13) Title content is here")
        self.secondSectionData.append("14) Title content is here")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.section = section
        switch section {
        case 0:
            return firstSectionData.count
        case 1:
            return secondSectionData.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = firstSectionData[indexPath.row]
        case 1:
            cell.textLabel?.text = secondSectionData[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }

        return 0.0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 && shouldHideFirstSectionHeader == false {
            return 233
        }

        if section == 2 {
            return 0
        }
        return 30.0
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 1 {
            if let header = view as? UITableViewHeaderFooterView {
                print("header = view as? UITableViewHeaderFooterView: \(header)")
                header.textLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            }
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Header content"
        case 1:
            return "Header content"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let noView = UIView()
        if section == 0 {
            return noView
        }

        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 10, width:
                tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)

        return headerView
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "This is Section2 Footer"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()

        if section == 0 && shouldShowCoviPlayer && !shouldHideFirstSectionHeader {
            return coviPlayer
        }

        return footerView
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let addAction = UIContextualAction(style: .destructive, title: "Add") { (action, view, handler) in
            switch indexPath.section {
            case 0:
                self.firstSectionData.insert("New Row Added", at: indexPath.row + 1)
                print("New Row Added")
                tableView.reloadData()

            case 1:
                let alertController = UIAlertController(title: "Add Data", message: "Please add the title contents", preferredStyle: .alert)
                alertController.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = "Enter New title contents"
                })

                let save = UIAlertAction(title: "Save", style: .default) { [weak self] (action: UIAlertAction) in
                    guard let textField = alertController.textFields?.first,
                        let userInputText = textField.text, !userInputText.isEmpty else {
                        return
                    }

                    self?.newTitleContent = userInputText

                    self?.secondSectionData.insert(userInputText, at: indexPath.row + 1)
                    tableView.reloadData()
                }

                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertController.addAction(cancel)
                alertController.addAction(save)
                self.present(alertController, animated: true, completion: nil)

            default:
                return
            }
        }
        addAction.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [addAction])
        configuration.performsFirstActionWithFullSwipe = true

        return configuration
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            switch indexPath.section {
            case 0:
                self.firstSectionData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadRows(at: [indexPath], with: .fade)

            case 1:
                self.secondSectionData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadRows(at: [indexPath], with: .fade)

            default:
                return
            }
        }
        deleteAction.backgroundColor = .orange
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true

        return configuration
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return true
        case 1:
            return true
        default:
            return false
        }
    }
}
