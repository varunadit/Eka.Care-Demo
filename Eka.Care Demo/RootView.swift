//
//  RootView.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            NavigationStack {
                ArticlesListView()
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
            
            NavigationStack {
                SavedArticlesList()
            }
            .tabItem {
                Image(systemName: "bookmark")
            }
            .tag(1)
        }
        .tint(.textTint)

    }
}
