//
//  RecipeRowImageView.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import SwiftUI

struct RecipeRowImageView: View {
    @StateObject var imageLoader: ImageLoader
    @State private var showingSheet = false
    
    init(recipe: Recipe) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(recipe: recipe))
    }
    
    var body: some View {
        Group {
            ZStack {
                if let image = imageLoader.smallImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .cornerRadius(8)
                } else if imageLoader.isLoading {
                    ProgressView()
                        .frame(width: 70, height: 70)
                } else {
                    Image(systemName: "fork.knife.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .opacity(0.5)
                }
            }
            .task {
                try? await imageLoader.loadImages()
            }
            .onTapGesture {
                if imageLoader.largeImage != nil {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                if let largeImage = imageLoader.largeImage {
                    ImageDetailView(largeImage: Image(uiImage: largeImage))
                }
            }
        }
    }
}
