//
//  ArticlesListVM.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import Combine
import SwiftUI
import CoreData

class ArticlesListVM: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var selectedArticle: Article? = nil
    
    var selectedArticleURL: URL? {
        URL(string: selectedArticle?.url ?? "")
    }

    private var cancellables: Set<AnyCancellable> = []

    init() {
        setupSearchListener()
    }

    func fetchData() {
        NetworkManager.shared.fetch(.articleListForQuery(searchText), for: ArticlesListResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    switch error {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    self.articles = response.articles ?? []
                }
            )
            .store(in: &cancellables)
    }

    private func setupSearchListener() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                self.fetchData()
            }
            .store(in: &cancellables)
    }
}


