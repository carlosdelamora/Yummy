//
//  NetworkConfigs.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import Foundation

protocol NetworkConfigs {
    var baseURL: URL? { get }
}

struct DefaultNetworkConfigs: NetworkConfigs {
    let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
}

struct MalformedNetworkConfigs: NetworkConfigs {
    let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
}

struct EmptyNetworkConfigs: NetworkConfigs {
    let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
}

enum NetworkConfigsError: Error {
    case invalidURL
}
