//
//  RecipeCardView.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    var body: some View {
        ZStack {
            AsyncImageView(url: recipe.photoURL)
                .scaledToFill()
                .frame(height: height)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        Text(recipe.cusine)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                }
                .frame(minHeight: labelHeight)
                .background(Color.white.opacity(0.8))
            }
        }
        .frame(height: height + labelHeight)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10)
    }
    
    private let height: CGFloat = 200
    private let labelHeight: CGFloat = 60
}

#Preview {
    let recipe = Recipe(
        id: UUID(),
        cusine: "Malaysian",
        name: "Apam Balik",
        photoURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
    )
    ZStack {
        Color.gray
        RecipeCardView(recipe: recipe)
            .padding()
    }
    
}
