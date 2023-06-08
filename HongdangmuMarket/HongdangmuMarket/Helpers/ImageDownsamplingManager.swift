//
//  ImageDownsamplingManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/28.
//

import UIKit.UIImage

struct ImageDownsamplingManager {
  
  func downsample(images: [UIImage]) -> [UIImage] {
    var resizedImages: [UIImage] = []
    
    images.forEach { image in
      let resizedImage = image.resized(withNewWidth: 400)
      resizedImages.append(resizedImage)
    }
    
    return resizedImages
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
