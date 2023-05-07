//
//  ImagePicker.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var selectedImages: [UIImage]
  @Binding var shouldPresentImagePicker: Bool
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    configuration.selectionLimit = 5
    
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = context.coordinator
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    return ImagePicker.Coordinator(parent: self)
  }
  
}

extension ImagePicker {
  
  final class Coordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: ImagePicker
    
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.shouldPresentImagePicker.toggle()
      
      results.forEach { image in
        if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
          image.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard error == nil else {
              return
            }
            
            guard let image = image as? UIImage else {
              return
            }
            
            DispatchQueue.main.async {
              self.parent.selectedImages.append(image)
            }
          }
        } else {
          fatalError("UIImage 타입으로 로드 불가")
        }
      }
    }
  }
  
}
