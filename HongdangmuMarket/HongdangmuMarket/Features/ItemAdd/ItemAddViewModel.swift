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

private extension ItemAddViewModel {
    
    func processInputToData() -> Data {
        guard let price = Double(price) else {
            return Data()
        }
        
        let addRequestItemDTO = AddRequestItemDTO(
            name: title,
            price: price,
            discountedPrice: 0,
            currency: "KRW",
            stock: 1,
            description: description
        )
        
        return addRequestItemDTO.toData()
    }

}
