//
//  CachedAsyncImageViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/03.
//

import SwiftUI

final class CachedAsyncImageViewModel: ObservableObject {
  
  @Published private(set) var image: Image?
  @Published private(set) var isImageReady: Bool = false
  
  let imageURL: String
  private let networkManager = NetworkManager()
  private let imageCacheManager = ImageCacheManager.shared
  
  init(imageURL: String) {
    self.imageURL = imageURL
  }
  
  func imageIsNeeded() {
    Task {
      await updateImage(from: imageURL)
    }
  }
  
}

private extension CachedAsyncImageViewModel {
  
  func updateImage(from urlString: String) async {
    let loadedUIImage = await loadImage(from: urlString)
    await MainActor.run { [weak self] in
      self?.image = Image(uiImage: loadedUIImage)
      self?.isImageReady = true
    }
  }
  
  func loadImage(from urlString: String) async -> UIImage {
    if let cachedUIImage: UIImage = imageCacheManager.image(forKey: urlString) {
      return cachedUIImage
    } else {
      let downloadedUIImage = await uiImage(from: urlString)
      imageCacheManager.save(image: downloadedUIImage, forKey: urlString)
      
      return downloadedUIImage
    }
  }
  
  func uiImage(from urlString: String) async -> UIImage {
    guard let url = URL(string: urlString),
          let imageData: Data = try? await NetworkManager().data(from: url),
          let uiImage = UIImage(data: imageData) else {
      return UIImage()
    }
    
    return uiImage
  }
  
}
