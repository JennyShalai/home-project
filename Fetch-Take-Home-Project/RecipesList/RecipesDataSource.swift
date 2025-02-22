//
//  RecipesDataSource.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import Foundation

protocol Refreshable {
    func refresh() async
}

@MainActor
class RecipesDataSource: ObservableObject, Refreshable {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var failedToLoadInitialData = false
    @Published private(set) var isLoading = false
    
    func refresh() async {
        await resetState()
        await loadInitialData()
    }
    
    private func resetState() async {
        recipes = []
        failedToLoadInitialData = false
        isLoading = false
    }
    
    private func loadInitialData() async {
        isLoading = true
        
        do {
            let recipesResponse = try await APIService.fetchRecipes()
            recipes = recipesResponse.recipes
        } catch let apiError as APIError {
            failedToLoadInitialData = true
            print("[App] API Error: \(apiError.localizedDescription)")
        } catch {
            failedToLoadInitialData = true
            print("[App] An unexpected error occurred: \(error)")
        }
        
        isLoading = false
    }
}
