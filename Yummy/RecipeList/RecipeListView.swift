//
//  RecipeListView.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    
    var body: some View {
        switch viewModel.loadingState {
        case .empty: Text("No recipes found")
        case .error:
            Text("Error")
        case .loading:
            ProgressView()
                .task {
                    await viewModel.initalTask()
                }
        case .loaded(let recipes):
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
                .padding()
            }
            .refreshable {
                Task {
                    await viewModel.refreshTask()
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}
