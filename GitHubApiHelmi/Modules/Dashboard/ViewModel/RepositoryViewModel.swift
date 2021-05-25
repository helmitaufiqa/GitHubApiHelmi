//
//  RepositoryViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import UIKit

final class RepositoryViewModel {
    var coordinator: DashboardCoordinator?
    
    // MARK: - Get Repo Services
    
    var repositoryResponseModel: RepositoryModel?
    var messageRepository: String?
    var refreshControl: UIRefreshControl!
    
    func refresh(tableView: UITableView) {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    var sucessMessageRepository: String? {
        get {
            if let item = repositoryResponseModel?.items {
                return "Success get repo : \(item)"
            }
            return nil
        }
    }
    
    func getRepository(model: ParameterModel, completion: @escaping ((ViewModelState) -> Void)) {
        APIRepositories.getRepositoryServices(model: model) { (model) in
            if model.items.count > 0 {
                self.repositoryResponseModel = model
                completion(.success)
            } else {
                self.messageRepository = "message"
                completion(.failure)
            }
        }
    }
}
