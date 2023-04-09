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
        let addRequestItemDTO = AddRequestItemDTO(
            name: title, //TODO: 3글자 미만 예외처리
            price: Double(price) ?? 0,
            discountedPrice: 0,
            currency: "KRW",
            stock: 1,
            description: description //TODO: 10글자 미만 예외처리
        )
        
        return addRequestItemDTO.toData()
    }

}
