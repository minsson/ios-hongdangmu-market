//
//  ItemAddViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemAddViewModel: ObservableObject {
 
    @Published var selectedImages: [UIImage] = []
    @Published var shouldPresentImagePicker = false
    
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
}
