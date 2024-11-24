//
//  RecipeListViewModelTests.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import Testing
import Factory
@testable import Yummy

struct RecipeListViewModelTests {

    @Test func loaded() async throws {
        
    }
    
    
    func makeViewModel(responses: [RecipeResponseStub]) {
        Container.shared.recipeProvider.register {
            RecipesProvidingStub(responses: responses)
        }
    }

}
