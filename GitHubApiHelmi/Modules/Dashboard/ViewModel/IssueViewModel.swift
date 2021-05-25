//
//  IssueViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import UIKit

final class IssueViewModel {
    var coordinator: DashboardCoordinator?
    
    // MARK: - Get Issue Services
    
    var issueResponseModel: IssueModel?
    var messageIssue: String?
    var refreshControl: UIRefreshControl!
    
    func refresh(tableView: UITableView) {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    var sucessMessageIssue: String? {
        get {
            if let item = issueResponseModel?.items {
                return "Success get repo : \(item)"
            }
            return nil
        }
    }
    
    func getIssue(model: ParameterModel, completion: @escaping ((ViewModelState) -> Void)) {
        APIIssue.getIssueServices(model: model) { (model) in
            if model.items.count > 0 {
                self.issueResponseModel = model
                completion(.success)
            } else {
                self.messageIssue = "message"
                completion(.failure)
            }
        }
    }
}
