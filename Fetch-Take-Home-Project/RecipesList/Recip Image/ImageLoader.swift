//
//  ImageLoader.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var largeImage: UIImage?
    @Published var smallImage: UIImage?
    @Published var isLoading = false
    
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func loadImages() async throws {
        await MainActor.run {
            self.isLoading = true
        }
        
        async let largeImageData = loadImageData(from: recipe.photoUrlLarge)
        async let smallImageData = loadImageData(from: recipe.photoUrlSmall)
        
        let largeData = try await largeImageData
        let smallData = try await smallImageData
        
        await MainActor.run {
            if let largeData = largeData, let image = UIImage(data: largeData) {
                self.largeImage = image
                ImageCache.shared.setImage(image, for: recipe.photoUrlLarge ?? "")
            }
            
            if let smallData = smallData, let image = UIImage(data: smallData) {
                self.smallImage = image
                ImageCache.shared.setImage(image, for: recipe.photoUrlSmall ?? "")
            }
            
            isLoading = false
        }
    }
    
    private func loadImageData(from urlString: String?) async throws -> Data? {
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil }
        
        if let cachedImage = ImageCache.shared.getImage(for: urlString) {
            return cachedImage.jpegData(compressionQuality: 0.8)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
