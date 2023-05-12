//
//  ItemEditViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import UIKit.UIImage

final class ItemEditViewModel: ObservableObject, ItemAddEditViewModelProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  
  @Published var selectedImages: [UIImage] = []
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
}
