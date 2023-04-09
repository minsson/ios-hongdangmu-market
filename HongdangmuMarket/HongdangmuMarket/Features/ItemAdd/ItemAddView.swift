//
//  ItemAddView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemAddView: View {
    
    @StateObject private var viewModel = ItemAddViewModel()
    
    var body: some View {
        ScrollView {
            ImagePickerView(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
            ImagePicker(
                selectedImages: $viewModel.selectedImages,
                shouldPresentImagePicker: $viewModel.shouldPresentImagePicker
            )
        }
    }
    
}

fileprivate struct ImagePickerView: View {
    
    @ObservedObject var viewModel: ItemAddViewModel
    
    private let imageSize: CGFloat = 75
    private let imageCornerRadius: CGFloat = 4
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                imageAddButton
                
                selectedImages
            }
        }
        .padding()
    }
    
}

private extension ImagePickerView {
    
    var imageAddButton: some View {
        Button {
            viewModel.shouldPresentImagePicker = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: imageCornerRadius)
                    .stroke(Color(UIColor.systemGray4))
                    .frame(width: imageSize, height: imageSize)
                
                Image(systemName: "camera.fill")
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.title3)
            }
        }
    }
    
    var selectedImages: some View {
        ForEach(viewModel.selectedImages, id: \.self) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
        }
    }
    
}

struct ItemAddView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemAddView()
    }
    
}
