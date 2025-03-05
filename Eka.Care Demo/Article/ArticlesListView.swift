//
//  ArticlesListView.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import SwiftUI

struct ArticlesListView: View {
    @StateObject var articlesViewModel: ArticlesListVM = .init()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(articlesViewModel.articles) { article in
                        Button {
                            articlesViewModel.selectedArticle = article
                        } label: {
                            ArticleCell(article: article)
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    TextField("Search articles...", text: $articlesViewModel.searchText)
                        .foregroundStyle(Color.textTint)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
            .navigationDestination(item: $articlesViewModel.selectedArticle, destination: { article in
                if let url = URL(string: article.url ?? "") {
                    ZStack {
                        WebArticleView(article: article, url: url)
                    }
                }
            })
            .navigationBarTitle("Articles")
        }
        .background {
            Color.accent
        }
    }
}

#Preview {
    ArticlesListView()
}

