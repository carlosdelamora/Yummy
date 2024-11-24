//
//  RecipiesProvider.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//


import Foundation
import Networking
import Factory

protocol RecipiesProviding: Sendable {
    func recipies() async throws -> RecipesResponseDTO
}

actor DefaultRecipesProvider: RecipiesProviding {
    
    func recipies() async throws -> RecipesResponseDTO {
        guard let url = networkConfigs.baseURL else { throw NetworkConfigsError.invalidURL }
        let urlRequest = URLRequest(url: url)
        return try await networkClient.urlRequest(responseType: RecipesResponseDTO.self, request: urlRequest)
    }
    
    @Injected(\.networkClient) private var networkClient
    @Injected(\.networkConfigs) private var networkConfigs
}

extension Container  {
    
    var networkClient: Factory<DefaultNetworkClient> {
        self { DefaultNetworkClient() }
    }
    
    var networkConfigs: Factory<NetworkConfigs> {
        self { DefaultNetworkConfigs() }
    }
}
