//
//  Recipe.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//
import Foundation

struct Recipe: Identifiable {
    let id: UUID
    let cusine: String
    let name: String
    let photoURL: URL?
}
