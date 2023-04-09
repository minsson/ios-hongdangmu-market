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
    
    func finishButtonTapped() {
        requestPostToServer()
    }
    
}

private extension ItemAddViewModel {
    
    func requestPostToServer() {
        let data = processInputToData()
        
        guard let urlRequest = API.AddItem(jsonData: data, images: selectedImages).urlRequest else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { Data, response, error in
            if let error = error {
                print(error)
                return
            }
        }.resume()
        
    }
    
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
