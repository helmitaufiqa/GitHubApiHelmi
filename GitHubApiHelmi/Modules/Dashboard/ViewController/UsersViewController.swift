//
//  UsersViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit
import SDWebImage

class UsersViewController: UIViewController {
    
    var viewModel: UserViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var perPage = 10
    private var page = 1
    private var searchQuery = ""
    @objc private var loadMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        setupLoadMoreButton()
        getUser(query: "a")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refresh(tableView: tableView)
        viewModel.refreshControl.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
    }
    
    @objc func refreshHandler() {
        viewModel.refreshControl.endRefreshing()
        if searchQuery == "" || searchQuery == " " {
            getUser(query: "a")
        } else {
            getUser(query: searchQuery)
        }
    }
    
    @IBAction func onSearch(_ sender: UITextField) {
        guard let query = sender.text else {
            return
        }
        searchQuery = query
        if query == " " || query == "" {
            getUser(query: "a")
        } else {
            getUser(query: query)
        }
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total = 0
        
        if let count = viewModel.userResponseModel?.items.count {
            total = count
        }
        return total
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsersTableViewCell
        
        if let data = viewModel.userResponseModel?.items[indexPath.row] {
            cell.nameLabel.text = "\(data.id)"
            let imageURL = data.avatarURL
            cell.profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = self.tableView.numberOfSections - 1
        let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        guard let count = viewModel.userResponseModel?.items.count,
              let totalCount = viewModel.userResponseModel?.totalCount
        else { return }
        
        if indexPath.row == lastRowIndex && count < totalCount {
            self.tableView.tableFooterView = loadMoreButton
            self.tableView.tableFooterView?.isHidden = false
            self.tableView.tableFooterView?.isUserInteractionEnabled = true
            
            loadMoreButton.addTarget(self, action: #selector(loadMoreItem(sender:)), for: .touchUpInside)
        } else {
            if count == totalCount {
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    @objc func loadMoreItem(sender: UIButton) {
        let lastSectionIndex = self.tableView.numberOfSections - 1
        let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        guard let totalCount = viewModel.userResponseModel?.totalCount else { return }
        
        self.perPage += 10
        
        if self.perPage <= totalCount {
            if searchQuery == "" || searchQuery == " " {
                getUser(query: "a")
            } else {
                getUser(query: searchQuery)
            }
            
            self.tableView.scrollToRow(at: [0, lastRowIndex], at: .bottom, animated: true)
        }
    }
}

extension UsersViewController {
    private func setupLoadMoreButton() {
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Load More", value: "Load More", table: nil)
        
        loadMoreButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 45))
        loadMoreButton.setTitleColor(.blue, for: .normal)
        let localize = localizedText
        loadMoreButton.setTitle(localize, for: .normal)
    }
    
    private func setupViews() {
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Search Users", value: "Load More", table: nil)
        
        let searchTFLayer = searchTextField.layer
        searchTFLayer.borderWidth = 1
        searchTFLayer.borderColor = UIColor.darkGray.cgColor
        searchTFLayer.cornerRadius = 20
        
        searchTextField.setupDoneButton()
        searchTextField.setupTextFieldPadding()
        searchTextField.placeholder = localizedText
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "UsersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Get User Services
    fileprivate func getUser(query: String) {
        let data = ParameterModel(query: query, perPage: perPage, page: page)
        
        viewModel.getUser(model: data) { (state) in
            switch state {
            case .success:
                self.onSuccessGetUser()
            case .failure:
                self.onErrorGetUser()
            }
        }
    }
    
    fileprivate func onSuccessGetUser() {
        guard let message = viewModel.sucessMessageUser else { return }
        print(message)
        self.tableView.reloadData()
    }
    
    fileprivate func onErrorGetUser() {
        guard let errorMessage = viewModel.messageUser else { return }
        print(errorMessage)
    }
}
