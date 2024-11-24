//
//  ImageCache.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import Foundation
import SwiftUI
import Factory

protocol ImageCache: Sendable {
    func saveImage(_ image: UIImage, forKey key: String) async
    func loadImage(forKey key: String) async -> UIImage?
    func clearCache() async
}

actor DefaultImageCache: ImageCache {
    
    //MARK: - API
    
    init(directoryName: String = "ImageCache") {
        let fileManager = FileManager.default
        if let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectory = cacheURL.appendingPathComponent(directoryName, isDirectory: true)
        } else {
            fatalError("Unable to access caches directory.")
        }

        // Create the directory if it doesn't exist
        createCacheDirectory()
    }

    /**
     Saves an image to the cache directory.
     
     - Parameters:
     - image: The `UIImage` to be cached.
     - key: A unique key for identifying the cached image. **Note:** Ensure the key is stripped of punctuation characters to avoid conflicts with directory paths.
     
     This function converts the provided image to JPEG format and writes it to the cache directory. If the conversion fails or an error occurs while writing, it logs the error.
     
     - Important: If the `key` contains special characters such as slashes or punctuation, they may interfere with file paths. Use a sanitized key to avoid issues.
     */
    func saveImage(_ image: UIImage, forKey key: String) async {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard let data = image.jpegData(compressionQuality: 1) else {
            print("Failed to convert image to JPEG data.")
            return
        }

        do {
            try data.write(to: fileURL)
        } catch {
            print("Failed to save image to cache: \(error.localizedDescription)")
        }
    }
    
    /**
     Loads an image from the cache directory.
     
     - Parameter key: The unique key used to identify the cached image. **Note:** Ensure the key is stripped of punctuation characters to match the saved file name.
     - Returns: The cached `UIImage` if it exists; otherwise, `nil`.
     
     This function checks the cache directory for a file corresponding to the provided key. If the file exists, it loads and returns the image.
     */
    func loadImage(forKey key: String) async -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }
    
    /**
     Deletes an image from the cache directory.
     
     - Parameter key: The unique key used to identify the cached image. **Note:** Ensure the key is stripped of punctuation characters to match the saved file name.
     
     This function removes the cached file corresponding to the provided key from the cache directory. If the file does not exist or an error occurs while deleting, it logs the error.
     */
    func deleteImage(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key).appendingPathExtension("jpg")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("Failed to delete cached image: \(error.localizedDescription)")
            }
        }
    }

    func clearCache() {
        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in contents {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            print("Failed to clear cache: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Constants
    
    private let cacheDirectory: URL
    
    //MARK: - Implementation
    
    nonisolated
    private func createCacheDirectory() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create cache directory: \(error.localizedDescription)")
            }
        }
    }
}
