//
//  AsyncImageViewModel.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import Combine
import Foundation
import UIKit
import Factory

@MainActor
final class AsyncImageViewModel: ObservableObject {
    
    @Published var loadingState: AyncImageLoadingState = .loading
    func fetchImage(from url: URL?) async {
        guard let url else {
            loadingState = .failed
            return
        }
        
        // We check if the image is in the cache
        if let uiImage = imageProvider.loadImage(forKey: url.absoluteString) {
            loadingState = .loaded(Image(uiImage: uiImage))
            return
        }
        
    }
    
    @Injected(\.imageProvider) private var imageProvider
}

extension Container {
    
    var imageProvider: Factory<ImageProviding> {
        self { DefaultImageProvider() }
    }
}

enum AyncImageLoadingState {
    case loading
    case loaded(UIImage)
    case failed
}
