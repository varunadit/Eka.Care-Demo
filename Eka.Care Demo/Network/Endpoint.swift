//
//  Endpoints.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import Foundation

enum Endpoint {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://newsapi.org/v2")!
        }
    }
    
    var apiKey: String {
        switch self {
        default:
            return ProcessInfo.processInfo.environment["API_KEY"] ?? "93db0571c80c45e6bfa0abcb69f72874"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var endpoint: String {
        switch self {
        case .articleList:
            return "/everything"
        case .articleListForQuery(_):
            return "/everything"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "apiKey", value: apiKey)]
        switch self {
        case .articleList:
            break
        case .articleListForQuery(let query):
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        return queryItems
    }
    
    case articleList
    case articleListForQuery(String)
}

enum HTTPMethod: String {
    case get
    case post
}
