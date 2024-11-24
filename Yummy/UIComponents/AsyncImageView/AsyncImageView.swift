//
//  AsyncImageView.swift
//  Yummy
//
//  Created by Carlos De la mora on 11/24/24.
//

import SwiftUI
import UIKit

struct AsyncImageView: View {
    var url: URL?
    // We pass an key from an asset catalog in the main bundle.
    var errorImageKey: String?
    @StateObject private var viewModel = AsyncImageViewModel()
    
    var body: some View {
        switch viewModel.loadingState {
        case .loading:
            Color.gray
                .task {
                    await viewModel.fetchImage(from: url)
                }
        case .loaded(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
        case .failed:
            if let errorImageKey {
                Image(systemName: errorImageKey)
            } else {
                Color.gray
            }
        }
    }
}



#Preview {
    AsyncImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg"))
}
