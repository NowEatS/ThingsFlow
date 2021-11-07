//
//  IssueDetailViewController.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import UIKit
import SnapKit
import Kingfisher

class IssueDetailViewController: UIViewController {
    
    // MARK: - UIProperties
    private var userProfileView: UIView = UIView()
    private var userProfileImageView:UIImageView = UIImageView()
    private var userNameLabel: UILabel = UILabel()
    private var issueBodyTextView: UITextView = UITextView()
    
    // MARK: - Properties
    private var issue: Issue
    
    // MARK: - Initializer
    init(issue: Issue) {
        self.issue = issue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUILayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Custom Methods
    
    private func setUpUILayout() {
        view.backgroundColor = .systemBackground
        
        title = "\(issue.number)"
        
        view.addSubview(userProfileView)
        userProfileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(80.0)
        }
        
        let profileImageShadowView = UIView()
        userProfileView.addSubview(profileImageShadowView)
        profileImageShadowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(32.0)
            make.width.height.equalTo(40.0)
        }
        profileImageShadowView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        profileImageShadowView.layer.shadowOpacity = 0.7
        profileImageShadowView.layer.shadowRadius = 5.0
        
        profileImageShadowView.addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        userProfileImageView.contentMode = .scaleAspectFill
        userProfileImageView.kf.setImage(with: URL(string: issue.user.profileImageURL))
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.cornerRadius = 20.0
        
        userProfileView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageShadowView.snp.right).offset(32.0)
            make.right.equalToSuperview().offset(-32.0)
        }
        userNameLabel.text = issue.user.name
        
        view.addSubview(issueBodyTextView)
        issueBodyTextView.snp.makeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        issueBodyTextView.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        issueBodyTextView.isEditable = false
        if let issueBody = issue.body {
            issueBodyTextView.text = issueBody
        } else {
            issueBodyTextView.text = "Issue 내용이 없습니다."
            issueBodyTextView.font = .boldSystemFont(ofSize: 24.0)
        }
    }
}
