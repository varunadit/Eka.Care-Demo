//
//  WebArticleView.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let request = URLRequest(url: url)
        wkwebView.load(request)
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct WebArticleView: View {
    let article: Article
    let url: URL
    
    @StateObject var webArticleViewModel: WebArticleViewVM
    
    init(article: Article, url: URL) {
        self.article = article
        self.url = url
        _webArticleViewModel = StateObject(wrappedValue: WebArticleViewVM(article: article))
    }
    
    var body: some View {
        ZStack {
            WebView(url: url)
            VStack {
                Button {
                    webArticleViewModel.toggleBookmark(article: article)
                } label: {
                    Image(systemName: webArticleViewModel.isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(.textTint)
                        .frame(width: 32, height: 32)
                        .padding()
                        .background {
                            Circle().fill(Color.accent)
                                .padding(1)
                                .background {
                                    Circle().fill(Color.textTint)
                                }
                        }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .onAppear {
            webArticleViewModel.checkIfSaved(article: article)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: url, subject: Text("Shared from News App"), message: Text(article.title ?? "")) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.textTint)
                }
            }
        }
    }
    
}

