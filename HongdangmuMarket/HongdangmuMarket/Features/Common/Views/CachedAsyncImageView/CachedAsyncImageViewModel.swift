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
  let downsamplingWidth: CGFloat
  private let networkManager = NetworkManager()
  private let imageDownsamplingManager = ImageDownsamplingManager()
  private let imageCacheManager = ImageCacheManager.shared
  
  init(imageURL: String, withWidth downsamplingWidth: CGFloat) {
    self.downsamplingWidth = downsamplingWidth
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
    let loadedImage: UIImage = await loadImage(from: urlString)
    let downsampledImage: UIImage = imageDownsamplingManager.downsample(image: loadedImage, withNewWidth: downsamplingWidth)
    
    await MainActor.run { [weak self] in
      self?.image = Image(uiImage: downsampledImage)
      self?.isImageReady = true
    }
  }
  
  func loadImage(from urlString: String) async -> UIImage {
    if let cachedImage: UIImage = imageCacheManager.image(forKey: urlString) {
      return cachedImage
    } else {
      let downloadedImage: UIImage = await uiImage(from: urlString)
      imageCacheManager.save(image: downloadedImage, forKey: urlString)
      
      return downloadedImage
    }
  }
  
  func uiImage(from urlString: String) async -> UIImage {
    guard let url = URL(string: urlString),
          let imageData: Data = try? await NetworkManager().data(from: url),
          let image = UIImage(data: imageData) else {
      return UIImage()
    }
    
    return image
  }
  
}
