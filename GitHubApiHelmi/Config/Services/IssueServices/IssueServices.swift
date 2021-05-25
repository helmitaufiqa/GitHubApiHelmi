//
//  IssueServices.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import Moya

enum IssueServices {
    case getIssueServices(model: ParameterModel)
}

extension IssueServices: TargetType {
    var baseURL: URL {
        return URL(string: Constant.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getIssueServices:
            return "issues"
        }
    }
    
    var method: Method {
        switch self {
        case .getIssueServices:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getIssueServices(let model):
            let issueDictionary: [String: Any] = [
                "q" : model.query,
                "per_page" : model.perPage,
                "page": model.page,
            ]
            return .requestParameters(parameters: issueDictionary, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getIssueServices:
            return ["Accept": "application/json"]
        }
    }
    
    
}
