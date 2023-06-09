//
//  ImageCacheManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/03.
//

import UIKit.UIImage

final class ImageCacheManager: ObservableObject {
  
  static let shared = ImageCacheManager()
  private let cache: NSCache<NSString, CGImage> = {
    let cache = NSCache<NSString, CGImage>()
    cache.countLimit = 1100
    cache.totalCostLimit = 1024 * 1024 * 100
    return cache
  }()
  
  private init() { }
  
}

extension ImageCacheManager {
  
  func save(image: CGImage, forKey key: String) {
    cache.setObject(image, forKey: key as NSString)
  }
  
  func image(forKey key: String) -> CGImage? {
    cache.object(forKey: key as NSString)
  }
  
}
