//
//  ImageProvider.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import UIKit

protocol ImageProviding {
    func image(for url: URL) async -> UIImage?
}

actor DefaultImageProvider: ImageProviding {
    func image(for url: URL) async -> UIImage? {
        
    }
}
