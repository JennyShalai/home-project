//
//  Recipe.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import Foundation
import SwiftData

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(UUID.self, forKey: .id)
        // TO-DO:
        // According to the documentation, 'name' is a required property.
        // However, the backend is currently returning inconsistent data.
        // Refactor once the backend issue is resolved.
        if let nameString = try? values.decode(String.self, forKey: .name) {
            name = nameString
        } else {
            name = "Unknown Recipe"
        }
        cuisine = try values.decode(String.self, forKey: .cuisine)
        photoUrlLarge = try values.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        photoUrlSmall = try values.decodeIfPresent(String.self, forKey: .photoUrlSmall)
        sourceUrl = try values.decodeIfPresent(String.self, forKey: .sourceUrl)
        youtubeUrl = try values.decodeIfPresent(String.self, forKey: .youtubeUrl)
    }
}
