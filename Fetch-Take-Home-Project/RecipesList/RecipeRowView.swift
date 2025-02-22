//
//  RecipeRowView.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            RecipeRowImageView(recipe: recipe)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(recipe.cuisine)
                        .font(.body)
                        .foregroundColor(.black.opacity(0.5))
                }
                Spacer()
            }
            .padding()
        }
        .padding()
        .background(Color.purple.opacity(0.05))
        .cornerRadius(8)
    }
}
