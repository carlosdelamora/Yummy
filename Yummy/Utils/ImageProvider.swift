//
//  ImageProvider.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import UIKit
import Factory

protocol ImageProviding: Sendable {
    func image(for url: URL) async throws -> UIImage
}

actor DefaultImageProvider: ImageProviding {
    func image(for url: URL) async throws -> UIImage {
        // We check if the image is in the cache
        let imageKey = url.absoluteString.components(
            separatedBy: .punctuationCharacters).joined()
        
        if let uiImage = await imageCache.loadImage(forKey: imageKey) {
            return uiImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: data) else {
            throw ImageError.invalidImageData
        }
        // We save the image on the cache
        await imageCache.saveImage(uiImage, forKey: imageKey)
        return uiImage
    }
    
    @Injected(\.imageCache) private var imageCache
}

enum ImageError: Error {
    case invalidImageData
}

extension Container {
    
    var imageCache: Factory<ImageCache> {
        self { DefaultImageCache() }
    }
}
