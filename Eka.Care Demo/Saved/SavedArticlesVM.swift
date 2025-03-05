//
//  SavedArticlesVM.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import Combine
import CoreData

class SavedArticlesVM: ObservableObject {
    @Published var selectedArticle: Article? = nil
    @Published var savedArticles: [Article] = []
    @Published var filteredArticles: [Article] = []
    @Published var searchText: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupSearchListener()
    }
    
    func fetchSavedArticles() {
        let savedCoreDataArticles = DBManager.shared.read { (fetchRequest: NSFetchRequest<ArticleData>) in

        }
        savedArticles = savedCoreDataArticles.map { Article(from: $0) }
        filteredArticles = savedArticles
    }
    
    private func setupSearchListener() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { str in
                if str.isEmpty {
                    self.filteredArticles = self.savedArticles
                } else {
                    self.filteredArticles = self.savedArticles
                        .filter({ article in
                            if let title = article.title, let description = article.description {
                                return title.lowercased().contains(str.lowercased()) ||
                                description.lowercased().contains(str.lowercased())
                            } else if let title = article.title {
                                return title.lowercased().contains(str.lowercased())
                            } else if let description = article.description {
                                return description.lowercased().contains(str.lowercased())
                            }
                            return false
                        })
                }
            })
            .store(in: &cancellables)
    }
    
    func delete(article: Article) {
        let success = DBManager.shared.delete(proccess: { (fetchRequest: NSFetchRequest<ArticleData>) in
            fetchRequest.predicate = NSPredicate(format: "url == %@", article.url ?? "")
        }, deletedObjects: nil)
        if success {
            self.fetchSavedArticles()
        }
    }
}
