//
//  Constant.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import Foundation

struct Constant {
    
    static let BASE_URL: String = "https://api.github.com/search/"
}

struct ParameterModel: Codable {
    let query: String
    let perPage: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case perPage = "per_page"
        case page = "page"
    }
}

