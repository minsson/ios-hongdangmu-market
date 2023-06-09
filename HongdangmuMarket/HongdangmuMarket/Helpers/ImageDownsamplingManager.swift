//
//  ImageDownsamplingManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/28.
//

import UIKit.UIImage
import ImageIO

struct ImageDownsamplingManager {
  
  func downsample(images: [UIImage], withNewWidth newWidth: CGFloat) -> [UIImage] {
    var resizedImages: [UIImage] = []
    
    images.forEach { image in
      let resizedImage = image.resized(withNewWidth: newWidth)
      resizedImages.append(resizedImage)
    }
    
    return resizedImages
  }
  
  func downsample(imageData: Data, for size: CGSize, scale: CGFloat) -> CGImage? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
      return nil
    }
    
    let maxDimensionInPixels = max(size.width, size.height) * scale
    let downsampleOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
    ] as [CFString : Any] as CFDictionary

    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
      return nil
    }

    return downsampledImage
  }
  
}

fileprivate extension UIImage {
  
  func resized(withNewWidth newWidth: CGFloat) -> UIImage {
    let scale = newWidth / self.size.width
    let newHeight = self.size.height * scale
    
    let size = CGSize(width: newWidth, height: newHeight)
    let render = UIGraphicsImageRenderer(size: size)
    let renderImage = render.image { context in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    
    return renderImage
  }
  
}
