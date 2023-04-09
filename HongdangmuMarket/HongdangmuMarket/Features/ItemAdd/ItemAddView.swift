//
//  ItemAddView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemAddView: View {
    
    @StateObject private var viewModel = ItemAddViewModel()
    @Binding var shouldPresentItemAddView: Bool
    
    var body: some View {
        headerView
            .padding()
        
        Divider()
        
        ScrollView {
            ImagePickerView(viewModel: viewModel)
            
            Divider()
                .padding(.bottom, 8)
            
            TextField(text: $viewModel.title) {
                Text("글 제목")
            }
            .padding(.vertical, 8)
            
            Divider()
            
            TextField(text: $viewModel.price) {
                Text("₩ 가격 (선택사항)")
            }
            .keyboardType(.numberPad)
            .padding(.vertical, 8)
            
            Divider()
            
            textEditorWithPlaceholder
            .frame(minHeight: 160)
            
            Divider()
        }
        .padding()
        .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
            ImagePicker(
                selectedImages: $viewModel.selectedImages,
                shouldPresentImagePicker: $viewModel.shouldPresentImagePicker
            )
        }
    }
    
}

private extension ItemAddView {
    
    var headerView: some View {
        HStack() {
            Button {
                shouldPresentItemAddView.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.title3)
            }

            Spacer()
            
            Text("내 물건 팔기")
                .font(.body.bold())
            
            Spacer()
            
            Button {
                viewModel.finishButtonTapped()
                shouldPresentItemAddView.toggle()
            } label: {
                Text("완료")
                    .foregroundColor(.orange)
            }

        }
    }
    
    var textEditorWithPlaceholder: some View {
        ZStack(alignment: .leading) {
            if viewModel.description == "" {
                TextEditor(text: .constant("신림동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"))
                    .foregroundColor(.gray)
                    .disabled(true)
            }
            TextEditor(text: $viewModel.description)
                .opacity(viewModel.description.isEmpty ? 0.25 : 1)
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
            .padding(.bottom, 16)
        }
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
        ItemAddView(shouldPresentItemAddView: .constant(true))
    }

}
