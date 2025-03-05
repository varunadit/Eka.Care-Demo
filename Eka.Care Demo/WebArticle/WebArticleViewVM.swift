//
//  WebArticleViewVM.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import Foundation
import Combine
import CoreData

class WebArticleViewVM: ObservableObject {
    @Published var isSaved: Bool = false
    let article: Article
    
    init(article: Article) {
        self.article = article
        checkIfSaved(article: article)
    }
    
    func checkIfSaved(article: Article) {
        isSaved = fetchSavedArticles().contains(where: { $0.url == article.url })
    }
    
    func fetchSavedArticles() -> [ArticleData]{
        let savedCoreDataArticles = DBManager.shared.read { (fetchRequest: NSFetchRequest<ArticleData>) in

        }
        savedCoreDataArticles.forEach({
            print($0.url ?? "")
        })
        return savedCoreDataArticles
    }
    
    func toggleBookmark(article: Article) {
        if isSaved {
            let toggled = DBManager.shared.delete(proccess: { (fetchRequest: NSFetchRequest<ArticleData>) in
                fetchRequest.predicate = NSPredicate(format: "url == %@", article.url ?? "")
            }, deletedObjects: nil)
            isSaved = toggled ? !isSaved : isSaved
        } else {
            let created = DBManager.shared.create { (articleData: ArticleData) in
                articleData.title = article.title
                articleData.articleDescription = article.description
                articleData.url = article.url
                articleData.urlToImage = article.urlToImage
            }
            isSaved = created ? !isSaved : isSaved
        }
    }
}
