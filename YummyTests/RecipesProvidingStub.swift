//
//  RecipesProvidingStub.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//
@testable import Yummy

actor RecipesProvidingStub: RecipesProviding {
    //MARK: - API
    
    init(responses: [RecipeResponseStub]) {
        self.responses = responses.reversed()
    }
    
    
    func recipies() async throws -> RecipesResponseDTO {
        guard let nextResponse = responses.popLast() else {
            fatalError("Asking for more responses than expected")
        }
        
        switch nextResponse {
        case .success(let response):
            return response
        case .failure:
            throw StubError.error
        }
    }
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    private enum StubError: Error {
        case error
    }
    
    private var responses: [RecipeResponseStub]
}

enum RecipeResponseStub {
    case success(RecipesResponseDTO)
    case failure
}
