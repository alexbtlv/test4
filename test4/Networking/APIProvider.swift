//
//  APIProvider.swift
//  test4
//
//  Created by Alexander Batalov on 5/8/20.
//  Copyright © 2020 Alexander Batalov. All rights reserved.
//

import Moya

enum APIProvider {
    case getNews(page: Int)
}

extension APIProvider: TargetType {
    var baseURL: URL {
        return URL(string: "http://newsapi.org")!
    }

    var path: String {
        switch self {
        case .getNews:
            return "v2/top-headlines"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getNews(let page):
            return [ParameterKey.page       : page,
                    ParameterKey.country    : "us",
                    ParameterKey.pageSize   : 20,
                    ParameterKey.apiKey     : Constants.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return Task.requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }

    var headers: [String : String]? {
        return nil
    }
}
