//
//  APIRepositories.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 25/05/21.
//

import Moya

class APIRepositories {
    static let provider = MoyaProvider<RepositoriesServices>()
    
    static func getRepositoryServices(model: ParameterModel, completionHandler: @escaping(RepositoryModel) -> Void) {
        provider.request(.getRepositoryServices(model: model)) { result in
            switch result {
            case .success(let response):
                do {
                    let repoResponse = try JSONDecoder().decode(RepositoryModel.self, from: response.data)
                    completionHandler(repoResponse)
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
