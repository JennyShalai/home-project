//
//  RecipesListView.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject private var data = RecipesDataSource()
    
    var body: some View {
        NavigationView {
            Group {
                if data.failedToLoadInitialData {
                    DefaultScreenView(text: "Sorry, we couldn’t load the recipes. Please try again",
                                      image: "network.slash")
                } else if data.recipes.isEmpty && !data.isLoading {
                    DefaultScreenView(text: "No recipes found",
                                      image: "book.and.wrench.fill",
                                      color: Color.purple.opacity(0.5))
                } else if data.isLoading {
                    LoadingDataView()
                } else {
                    List {
                        ForEach(data.recipes) { recipe in
                            RecipeRowView(recipe: recipe)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Recipes of The Day")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        ImageCache.shared.clearCache()
                    }) {
                        Image(systemName: "arrow.trianglehead.2.counterclockwise")
                            .imageScale(.medium)
                            .foregroundColor(.purple)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            if data.recipes.isEmpty {
                Task { await data.refresh() }
            }
        }
        .refreshable {
            Task { await data.refresh() }
        }
    }
}

