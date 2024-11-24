//
//  RecipeListViewModel.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//
import Combine
import Factory

@MainActor
final class RecipeListViewModel: ObservableObject {
    
    //MARK: - API
    
    @Published var loadingState: RecipeListLoadingState = .loading
    
    
    func initalTask() async {
        await load()
    }
    
    func refreshTask() async {
        await load()
    }
    
    //MARK: - Constants
    
    
    //MARK: - Variables
    
    @Injected(\.recipeProvider) var recipeProvider
    
    //MARK: - Implementation
    
    private func load() async {
        // If is preloaded do not change the state while loading.
        // Remember that the loadingState are to drive the UI.
        let isPreLoaded = if case .loaded = loadingState { true } else { false }
        if !isPreLoaded {
            loadingState = .loading
        }
        do {
            let recipesResponse = try await recipeProvider.recipies()
            let recipes = recipesResponse.recipes.map(
                { Recipe(id: $0.id, cusine: $0.cuisine, name: $0.name, photoURL: $0.photoURL)
                })
            if !recipes.isEmpty {
                loadingState = .loaded(recipes)
            } else if !isPreLoaded {
                loadingState = .empty
            }
        } catch {
            if !isPreLoaded {
                loadingState = .error
            }
        }
    }
}

extension Container {
    
    var recipeProvider: Factory<RecipesProviding> {
        self { DefaultRecipesProvider() }
    }
}

enum RecipeListLoadingState {
    case loading
    case loaded([Recipe])
    case error
    case empty
}
