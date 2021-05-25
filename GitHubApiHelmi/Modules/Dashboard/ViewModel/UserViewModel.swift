//
//  UserViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import UIKit

final class UserViewModel {
    var coordinator: DashboardCoordinator?
    
    // MARK: - Requset Otp Code Services
    
    var userResponseModel: UserModelResponse?
    var messageUser: String?
    var refreshControl: UIRefreshControl!
    
    func refresh(tableView: UITableView) {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    var sucessMessageUser: String? {
        get {
            if let item = userResponseModel?.items {
                return "Success get user : \(item)"
            }
            return nil
        }
    }
    
    func getUser(model: ParameterModel, completion: @escaping ((ViewModelState) -> Void)) {
        APIUser.getUserServices(model: model) { (model) in
            if model.items.count > 0 {
                self.userResponseModel = model
                completion(.success)
            } else {
                self.messageUser = "Err"
                completion(.failure)
            }
        }
    }
}
