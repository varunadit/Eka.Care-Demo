//
//  ArticlesListResponse.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import Foundation

struct ArticlesListResponse: Decodable {
    let success: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Decodable, Hashable, Identifiable {
    var id: String {
        return url ?? ""
    }
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Source: Decodable, Hashable {
    let id: String?
    let name: String?
}

extension Article {
    init(from articleData: ArticleData) {
        self.title = articleData.title
        self.description = articleData.articleDescription
        self.url = articleData.url
        self.urlToImage = articleData.urlToImage
        self.source = nil
        self.author = nil
        self.publishedAt = nil
        self.content = nil
    }
}
