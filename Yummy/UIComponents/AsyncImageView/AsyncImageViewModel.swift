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
        loadingState = .loading
        do {
            let image = try await imageProvider.image(for: url)
            loadingState = .loaded(image)
        } catch {
            loadingState = .failed
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
