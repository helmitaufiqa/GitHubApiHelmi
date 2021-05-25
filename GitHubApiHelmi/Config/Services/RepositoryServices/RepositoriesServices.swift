//
//  RepositoriesServices.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import Moya

enum RepositoriesServices {
    case getRepositoryServices(model: ParameterModel)
}

extension RepositoriesServices: TargetType {
    var baseURL: URL {
        return URL(string: Constant.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getRepositoryServices:
            return "repositories"
        }
    }
    
    var method: Method {
        switch self {
        case .getRepositoryServices:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepositoryServices(let model):
            let repoDictionary: [String: Any] = [
                "q" : model.query,
                "per_page" : model.perPage,
                "page": model.page,
            ]
            return .requestParameters(parameters: repoDictionary, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getRepositoryServices:
            return ["Accept": "application/json"]
        }
    }
    
    
}

