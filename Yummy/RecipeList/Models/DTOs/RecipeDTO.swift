//
//  Untitled.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//
import Foundation

struct RecipeDTO: Decodable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURL = "photo_url_small"
    }
}
