//
//  APIIssue.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import Moya

class APIIssue {
    static let provider = MoyaProvider<IssueServices>()
    
    static func getIssueServices(model: ParameterModel, completionHandler: @escaping(IssueModel) -> Void) {
        provider.request(.getIssueServices(model: model)) { result in
            switch result {
            case .success(let response):
                do {
                    let issueResponse = try JSONDecoder().decode(IssueModel.self, from: response.data)
                    completionHandler(issueResponse)
                } catch let err {
                    print(err)
                }
                break
            case .failure(let error):
                print(error.errorDescription ?? error)
                break
            }
        }
    }
}

