//
//  APIService.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import Foundation
import Combine

class APIService {
    static func fetchRecipes() async throws -> RecipesResponse {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 400, 405...499:
            let errorString: String
            if let json = try? JSONSerialization.jsonObject(with: data),
               let dictionary = json as? [String: Any],
               let errorMessage = dictionary["message"] as? String {
                errorString = errorMessage
            } else {
                print("[App] wrong backend error response format. Message not found.")
                errorString = "Unknown error"
            }
            throw APIError.badRequest(error: errorString)
        case 500...599:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            break
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(RecipesResponse.self, from: data)
    }
}
