//
//  ImageCacheManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/03.
//

import UIKit.UIImage

final class ImageCacheManager: ObservableObject {
  
  static let shared = ImageCacheManager()
  private let cache: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    cache.countLimit = 50
    cache.totalCostLimit = 1024 * 1024 * 100
    return cache
  }()
  
  private init() { }
  
}

extension ImageCacheManager {
  
  func save(image: UIImage, forKey key: String) {
    cache.setObject(image, forKey: key as NSString)
  }
  
  func image(forKey key: String) -> UIImage? {
    cache.object(forKey: key as NSString)
  }
  
}
