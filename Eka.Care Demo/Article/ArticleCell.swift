//
//  ArticleCell.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import SwiftUI

struct ArticleCell: View {
    let article: Article

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "No Title")
                    .font(.headline)
                    .lineLimit(1)
                Text(article.description ?? "No Description")
                    .font(.subheadline)
                    .lineLimit(2)
                
                Spacer()

                HStack {
                    Spacer()
                    Text("Read More...")
                        .font(.caption)
                }
            }
            .foregroundStyle(Color.textTint)
            .padding(.leading, 8)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.accent))
    }
}
