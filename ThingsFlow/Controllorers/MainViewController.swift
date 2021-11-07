//
//  MainViewController.swift
//  ThingsFlow
//
//  Created by 서태원 on 2021/11/07.
//

import UIKit
import SnapKit
import SafariServices

class MainViewController: UIViewController {
    
    //MARK: - UI Properties
    private var tableView: UITableView = UITableView()
    
    // MARK: - Properties
    private var owner: String = "apple"
    private var repository: String = "swift"
    private var issues: [Issue] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUILayout()
        setUpTableView()
        checkUserDefaluts()
        requestIssueList(owner: owner, repository: repository)
    }
    
    // MARK: - Custom Methods
    private func setUpUILayout() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(tapSearchButton))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func requestIssueList(owner: String, repository: String) {
        TFNetworkManager.shared.getIssueList(owner: owner, repository: repository) { [weak self] result in
            switch result {
            case let .success(issues):
                self?.issues = issues
                self?.setUserDefaults(owner: owner, repository: repository)
                self?.reloadTableview()
                
            case let .failure(error):
                print(error.rawValue)
                self?.showErrorAlert(errorMessage: error.rawValue)
            }
        }
    }
    
    private func checkUserDefaluts() {
        let userDefaluts = UserDefaults.standard
        guard let owner = userDefaluts.value(forKey: UDKey.owner) as? String, let repository = userDefaluts.value(forKey: UDKey.repository) as? String else { return }
        self.owner = owner
        self.repository = repository
    }
    
    private func setUserDefaults(owner: String, repository: String) {
        let userDefaluts = UserDefaults.standard
        self.owner = owner
        self.repository = repository
        userDefaluts.setValue(owner, forKey: UDKey.owner)
        userDefaluts.setValue(repository, forKey: UDKey.repository)
    }
    
    private func showErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // MARK: - OBJ Methods
    @objc private func tapSearchButton() {
        print("SearchButton is Tapped")
        
        let alertController = UIAlertController(title: nil, message: "소유자와 저장소를 입력하세요.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "소유자"
        }
        alertController.addTextField { textField in
            textField.placeholder = "저장소"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let searchAction = UIAlertAction(title: "검색", style: .default) { _ in
            guard let ownerText = alertController.textFields?.first?.text,
                  let repositoryText = alertController.textFields?.last?.text,
                  ownerText.isEmpty == false,
                  repositoryText.isEmpty == false else {
                      self.showErrorAlert(errorMessage: "올바른 값을 입력해주세요.")
                return
            }
            self.requestIssueList(owner: ownerText, repository: repositoryText)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(searchAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - Extension for UITableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    private func reloadTableview() {
        DispatchQueue.main.async {
            self.title = "\(self.owner)/\(self.repository)"
            self.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TFTableViewCell.self, forCellReuseIdentifier: TFTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count >= 5 ? issues.count+1 : issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TFTableViewCell.identifier, for: indexPath) as? TFTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row == 4 {
            cell.setThingsFlowBanner()
        } else {
            let issue = indexPath.row > 4 ? issues[indexPath.row-1] : issues[indexPath.row]
            let cellTitle = "\(issue.number) - " + issue.title
            cell.setIndex(cellTitle)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            guard let url = URL(string: TFContentsURL.ThingsFlow_WebSite) else { return }
            UIApplication.shared.open(url, options: [:])
        } else {
            let issue = indexPath.row > 4 ? issues[indexPath.row-1] : issues[indexPath.row]
            let issueDetailVC = IssueDetailViewController(issue: issue)
            navigationController?.pushViewController(issueDetailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
