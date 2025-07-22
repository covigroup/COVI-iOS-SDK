//
//  ViewController.swift
//  COVI-iOS-SDK
//
//  Copyright (c) 2025 covi. All rights reserved.
//

import UIKit
import covisdk

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
        coviPlayer?.removeFromSuperview()
        coviPlayer?.appViewController = nil
        coviPlayer = nil
        
        shouldShowCoviPlayer = false
    }

    func createCovi() -> CoviPlayer {
        let width = UIScreen.main.bounds.width
        let height = ceil(width / 1440.0 * 810.0)

        let coviPlayer = CoviPlayer(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))

        // 필수
        coviPlayer.type = "dev"
        coviPlayer.pcode = "매체사 PCODE"
        coviPlayer.category = "매체사 카테고리"

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
