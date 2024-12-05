//
//  NetworkClient.swift
//  YummyModules
//
//  Created by Carlos De la mora on 11/24/24.
//

import Foundation

public protocol NetworkClient: Sendable {
    func urlRequest<T: Decodable>(responseType: T.Type, request: URLRequest) async throws -> T
}

public final class DefaultNetworkClient: NetworkClient {
    public init() {}
    public func urlRequest<T: Decodable>(responseType: T.Type, request: URLRequest) async throws -> T {
        let (data, httpResponse) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        let dto = try JSONDecoder().decode(T.self, from: data)
        return dto
    }
    
    enum NetworkError: Error {
        case invalidResponse
        case httpError(Int)
    }
}
