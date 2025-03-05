//
//  README.md
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

# 📰 SwiftUI News Reader App

## 🌟 Project Overview

A modern, feature-rich iOS news application built with SwiftUI that allows users to browse, read, and save articles from NewsAPI. The app provides a seamless reading experience with offline support, dark mode compatibility, and intuitive navigation.

## ✨ Features

- [x] Fetch latest news articles using NewsAPI
- [x] In-app article reading with WebView
- [x] Save and manage articles locally
- [x] Dark mode support
- [x] Search functionality for articles
- [x] Share articles via iOS ShareSheet
- [x] Offline article access

## 🛠 Tech Stack

- **UI Framework**: SwiftUI
- **Reactive Programming**: Combine
- **Networking**: URLSession
- **Local Storage**: Core Data
- **Web Rendering**: WebKit (WKWebView)

## 🏗 Architecture

The app follows a modular, MVVM (Model-View-ViewModel) architecture:

- **Models**:
  - `Article`: Represents news article data
  - `ArticleData`: Core Data entity for local storage

- **ViewModels**:
  - `ArticlesListVM`: Manages article list fetching and state
  - `SavedArticlesVM`: Handles saved articles logic
  - `WebArticleViewVM`: Manages bookmarking and article interactions

- **Managers**:
  - `NetworkManager`: Handles API requests
  - `DBManager`: Manages Core Data operations

## 🔧 Setup Instructions

### Prerequisites

- Xcode 16+
- iOS 18+
- Swift 5.9+
- NewsAPI Key

### Installation Steps

1. Clone the repository
```bash
git clone https://github.com/yourusername/news-app.git
```

2. Open the project in Xcode
3. Add your NewsAPI key in the `Endpoint` configuration
4. Install dependencies (if any)
5. Build and run the project

## 🔑 Configuration

### NewsAPI Integration

- Obtain an API key from [NewsAPI](https://newsapi.org/)
- Configure the `Endpoint` enum or ENV_KEY with your API key
- Customize endpoint parameters as needed

## 📦 Core Components

### Networking
- Type-safe network requests using Combine
- Custom `NetworkError` handling
- Generic fetch method supporting various model types

### Local Storage
- Core Data integration via `DBManager`
- CRUD operations for articles
- Offline article storage

### UI Components
- `ArticlesListView`: Main article browsing screen
- `SavedArticlesList`: Saved articles management
- `WebArticleView`: In-app article reading with bookmarking

## 🌓 Dark Mode Support

The app fully supports dark mode with a custom color palette:
- Adaptive accent colors
- Dynamic text and background colors
- Consistent UI across light and dark modes

## 🚀 Performance Optimizations

- Debounced search functionality
- Efficient Core Data operations
- Combine for reactive data flow

## 🔮 Future Improvements

- [ ] Implement article categorization
- [ ] Add pull-to-refresh
- [ ] Enhance error handling

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🙌 Acknowledgments

- [NewsAPI](https://newsapi.org/)

