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
  let downsamplingSize: CGSize
  private let networkManager = NetworkManager()
  private let imageDownsamplingManager = ImageDownsamplingManager()
  private let imageCacheManager = ImageCacheManager.shared
  
  init(imageURL: String, withSize downsamplingSize: CGSize) {
    self.downsamplingSize = downsamplingSize
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
    guard let loadedImage: CGImage = await loadImage(from: urlString) else {
      return
    }
    
    await MainActor.run { [weak self] in
      self?.image = Image(loadedImage, scale: 1.0, label: Text("Item Image"))
      self?.isImageReady = true
    }
  }
  
  func loadImage(from urlString: String) async -> CGImage? {
    if let cachedImage: CGImage = imageCacheManager.image(forKey: urlString) {
      return cachedImage
    } else {
      guard let downloadedImage: CGImage = await cgImage(from: urlString) else {
        return nil
      }
      imageCacheManager.save(image: downloadedImage, forKey: urlString)
      
      return downloadedImage
    }
  }
  
  func cgImage(from urlString: String) async -> CGImage? {
    guard let url = URL(string: urlString),
          let imageData: Data = try? await NetworkManager().data(from: url),
          let image: CGImage = imageDownsamplingManager.downsample(imageData: imageData, for: downsamplingSize, scale: 3.0) else {
      return nil
    }
    
    return image
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
