//
//  ImageCache.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-21.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private let fileManager = FileManager.default
    private let cacheURL: URL?
    
    private init() {
        cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("image_cache")
        
        if let cacheURL = cacheURL, !fileManager.fileExists(atPath: cacheURL.path) {
            try? fileManager.createDirectory(at: cacheURL, withIntermediateDirectories: true)
        }
    }
    
    func getImage(for url: String) -> UIImage? {
        guard let cacheURL = cacheURL,
              let fileName = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        let fileURL = cacheURL.appendingPathComponent(fileName)
        
        guard let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) else { return nil }
        return image
    }
    
    func setImage(_ image: UIImage, for url: String) {
        guard let cacheURL = cacheURL,
              let fileName = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let fileURL = cacheURL.appendingPathComponent(fileName)
        
        try? imageData.write(to: fileURL)
    }
    
    func clearCache() {
        guard let cacheURL = ImageCache.shared.cacheURL else { return }
        
        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil)
            
            for item in contents {
                try fileManager.removeItem(at: item)
            }
        } catch {
            print("[App] Error clearing cache: \(error)")
        }
    }
}
