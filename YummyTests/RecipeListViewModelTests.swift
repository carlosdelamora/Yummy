//
//  RecipeListViewModelTests.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import Testing
import Factory
import Foundation
@testable import Yummy

struct RecipeListViewModelTests {

    @MainActor
    @Test func initalTaskSuccess() async throws {
        let responseDTO = RecipesResponseDTO(recipes: makeRecipeDTOS(number: 4))
        let responses = [RecipeResponseStub.success(responseDTO)]
        let viewModel = makeViewModel(responses: responses)
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .loaded(let recipes): #expect(recipes.count == 4)
        default: #expect(Bool(false), Comment("LoadingState should be loaded not \(viewModel.loadingState)"))
        }
    }
    
    @MainActor
    @Test func initalTaskError() async throws {
        //let responseDTO = RecipesResponseDTO(recipes: makeRecipeDTOS(number: 4))
        let responses = [RecipeResponseStub.failure]
        let viewModel = makeViewModel(responses: responses)
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .error: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be error not \(viewModel.loadingState)"))
        }
    }
    
    @MainActor
    @Test func initalTaskEmpty() async throws {
        let responseDTO = RecipesResponseDTO(recipes: [])
        let responses = [RecipeResponseStub.success(responseDTO)]
        let viewModel = makeViewModel(responses: responses)
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .empty: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be empty not \(viewModel.loadingState)"))
        }
    }
    
    @MainActor
    @Test func refreshTaskLoadedOnEmpty() async throws {
        let responseEmptyDTO = RecipesResponseDTO(recipes: [])
        let responseRefreshDTO = RecipesResponseDTO(recipes: makeRecipeDTOS(number: 2))
        let responses = [RecipeResponseStub.success(responseEmptyDTO), .success(responseRefreshDTO)]
        let viewModel = makeViewModel(responses: responses)
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .empty: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be empty not \(viewModel.loadingState)"))
        }
        
        await viewModel.refreshTask()
        
        switch viewModel.loadingState {
        case .loaded(let recipes): #expect(recipes.count == 2)
        default: #expect(Bool(false), Comment("LoadingState should be loaded not \(viewModel.loadingState)"))
        }
    }
    
    @MainActor
    @Test func refreshTaskErrorOnLoaded() async throws {
        let responseDTO = RecipesResponseDTO(recipes: makeRecipeDTOS(number: 2))
        let responses = [RecipeResponseStub.success(responseDTO), .failure]
        let viewModel = makeViewModel(responses: responses)
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .loaded(let recipes): #expect(recipes.count == 2)
        default: #expect(Bool(false), Comment("LoadingState should be loaded not \(viewModel.loadingState)"))
        }
        
        await viewModel.refreshTask()
        // We expect that an error would not change the state when loaded.
        switch viewModel.loadingState {
        case .loaded(let recipes): #expect(recipes.count == 2)
        default: #expect(Bool(false), Comment("LoadingState should be loaded not \(viewModel.loadingState)"))
        }
    }
    
    @MainActor
    @Test func refreshTaskErrorOnEmpty() async throws {
        let responseEmptyDTO = RecipesResponseDTO(recipes: [])
        let responseDTO = RecipesResponseDTO(recipes: makeRecipeDTOS(number: 6))
        let responses = [RecipeResponseStub.success(responseEmptyDTO), .success(responseDTO)]
        let viewModel = makeViewModel(responses: responses)
       
        switch viewModel.loadingState {
        case .loading: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be loading not \(viewModel.loadingState)"))
        }
        
        await viewModel.initalTask()
        switch viewModel.loadingState {
        case .empty: #expect(true)
        default: #expect(Bool(false), Comment("LoadingState should be empty not \(viewModel.loadingState)"))
        }
        
        await viewModel.refreshTask()
        switch viewModel.loadingState {
        case .loaded(let recipes): #expect(recipes.count == 6)
        default: #expect(Bool(false), Comment("LoadingState should be loaded not \(viewModel.loadingState)"))
        }
    }
    
    
    @MainActor
    func makeViewModel(responses: [RecipeResponseStub]) -> RecipeListViewModel {
        Container.shared.recipeProvider.register {
            RecipesProvidingStub(responses: responses)
        }
        return RecipeListViewModel()
    }
    
    func makeRecipeDTOS(number: Int) -> [RecipeDTO] {
        guard let url =  URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg") else {
            fatalError("Fix the url")
        }
        
        return (0..<number).map { _ in
            let uuid = UUID()
            return RecipeDTO(id: uuid, name: uuid.uuidString, cuisine: "Italian", photoURL: url)
        }
    }

}
