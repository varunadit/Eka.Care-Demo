//
//  SavedArticlesList.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import SwiftUI

struct SavedArticlesList: View {
    @StateObject var savedArticlesVM: SavedArticlesVM = .init()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(savedArticlesVM.filteredArticles) { article in
                        Button {
                            savedArticlesVM.selectedArticle = article
                        } label: {
                            ArticleCell(article: article)
                        }
                        .swipeActions(content: {
                            Button {
                                withAnimation {
                                    savedArticlesVM.delete(article: article)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.red)

                        })
                        .listRowSeparator(.hidden)
                    }
                    
                } header: {
                    TextField("Search saved articles...", text: $savedArticlesVM.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
            .navigationDestination(item: $savedArticlesVM.selectedArticle, destination: { article in
                if let url = URL(string: article.url ?? "") {
                    ZStack {
                        WebArticleView(article: article, url: url)
                    }
                }
            })
            .navigationBarTitle("Saved Articles")
        }
        .onAppear {
            savedArticlesVM.fetchSavedArticles()
        }
    }
}
