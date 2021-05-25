//
//  IssueViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

class IssueViewController: UIViewController {
    
    var viewModel: IssueViewModel!

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var perPage = 10
    private var page = 1
    private var searchQuery = ""
    @objc private var loadMoreButton: UIButton!
    private var dates = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTableView()
        setupLoadMoreButton()
        getIssue(query: "a")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refresh(tableView: tableView)
        viewModel.refreshControl.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
    }
    
    @objc func refreshHandler() {
        viewModel.refreshControl.endRefreshing()
        if searchQuery == "" || searchQuery == " " {
            getIssue(query: "a")
        } else {
            getIssue(query: searchQuery)
        }
    }

    @IBAction func onSearch(_ sender: UITextField) {
        guard let query = sender.text else {
            return
        }
        if query == " " || query == "" {
            getIssue(query: "a")
        } else {
            getIssue(query: query)
        }
    }
}

extension IssueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total = 0
        
        if let count = viewModel.issueResponseModel?.items.count {
            total = count
        }
        return total
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as! IssueTableViewCell
        
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        if let data = viewModel.issueResponseModel?.items[indexPath.row] {
            let issueLocalize = bundle!.localizedString(forKey: "Issue:", value: "Issue:", table: nil)
            cell.titleLabel.text = "\(issueLocalize) \(data.title)"
            let isoDate = data.createdAt
            self.dateConvert(date: isoDate)
            
            cell.dateLabel.text = self.dates
            let localize = bundle!.localizedString(forKey: "Comments:", value: "Comments:", table: nil)
            cell.commentLabel.text = "\(localize) \(data.comments)"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = self.tableView.numberOfSections - 1
        let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        guard let count = viewModel.issueResponseModel?.items.count,
              let totalCount = viewModel.issueResponseModel?.totalCount
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
        
        guard let totalCount = viewModel.issueResponseModel?.totalCount else { return }
        
        self.perPage += 10
        
        if self.perPage <= totalCount {
            if searchQuery == "" || searchQuery == " " {
                getIssue(query: "a")
            } else {
                getIssue(query: searchQuery)
            }
            
            self.tableView.scrollToRow(at: [0, lastRowIndex], at: .bottom, animated: true)
        }
    }
    
    func dateConvert(date: String) {
        let str = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        dateFormatter.locale = Locale(identifier: "id")

        guard let date = dateFormatter.date(from: str) else {
            return
        }

        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd MMMM yyyy"
        let newStr = newDateFormatter.string(from: date)
        self.dates = newStr
    }
}


extension IssueViewController {
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
        let localizedText = bundle!.localizedString(forKey: "Search Issues", value: "Search Issues", table: nil)
        
        let searchTFLayer = searchTextField.layer
        searchTFLayer.borderWidth = 1
        searchTFLayer.borderColor = UIColor.darkGray.cgColor
        searchTFLayer.cornerRadius = 20
        
        searchTextField.setupDoneButton()
        searchTextField.setupTextFieldPadding()
        searchTextField.placeholder = localizedText
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "IssueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IssueCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Get Issue Services
    fileprivate func getIssue(query: String) {
        let data = ParameterModel(query: query, perPage: perPage, page: 1)
        
        viewModel.getIssue(model: data) { (state) in
            switch state {
            case .success:
                self.onSuccessGetIssue()
            case .failure:
                self.onErrorGetIssue()
            }
        }
    }
    
    fileprivate func onSuccessGetIssue() {
        guard let message = viewModel.sucessMessageIssue else { return }
        print(message)
        self.tableView.reloadData()
    }
    
    fileprivate func onErrorGetIssue() {
        guard let errorMessage = viewModel.messageIssue else { return }
        print(errorMessage)
    }
}
