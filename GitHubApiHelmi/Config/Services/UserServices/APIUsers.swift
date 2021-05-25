//
//  APIUsers.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import Moya

class APIUser {
    static let provider = MoyaProvider<UserServices>()
    
    static func getUserServices(model: ParameterModel, completionHandler: @escaping(UserModelResponse) -> Void) {
        provider.request(.getUserServices(model: model)) { result in
            switch result {
            case .success(let response):
                do {
                    let userResponse = try JSONDecoder().decode(UserModelResponse.self, from: response.data)
                    completionHandler(userResponse)
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
