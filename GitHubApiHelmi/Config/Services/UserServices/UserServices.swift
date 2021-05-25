//
//  UserServices.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import Moya

enum UserServices {
    case getUserServices(model: ParameterModel)
}

extension UserServices: TargetType {
    var baseURL: URL {
        return URL(string: Constant.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getUserServices:
            return "users"
        }
    }
    
    var method: Method {
        switch self {
        case .getUserServices:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUserServices(let model):
            let userDictionary: [String: Any] = [
                "q" : model.query,
                "per_page" : model.perPage,
                "page": model.page,
            ]
            return .requestParameters(parameters: userDictionary, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUserServices:
            return ["Accept": "application/json"]
        }
    }
    
    
}
