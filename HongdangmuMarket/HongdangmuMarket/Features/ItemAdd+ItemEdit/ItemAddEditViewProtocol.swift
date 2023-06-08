//
//  ItemAddEditView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/12.
//

import SwiftUI

protocol ItemAddEditViewProtocol { }

extension ItemAddEditViewProtocol {
  
  func headerView(title: String, dismiss: DismissAction, finishAction: @escaping () -> ()) -> some View {
    HStack() {
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(Color(UIColor.systemGray))
          .font(.title3)
      }

      Spacer()

      Text(title)
        .font(.body.bold())

      Spacer()

      Button {
        finishAction()
        dismiss()
      } label: {
        Text("완료")
          .foregroundColor(.orange)
      }
    }
  }

  func titleTextField(_ title: Binding<String>) -> some View {
    TextField(text: title) {
      Text("글 제목")
    }
  }
  
  func priceTextField(_ price: Binding<String>) -> some View {
    CurrencyTextField(placeholder: "₩ 가격 (선택사항)", currency: .krw, text: price)
        .keyboardType(.numberPad)
  }
  
  func textEditorWithPlaceholder(for description: Binding<String>) -> some View {
    ZStack(alignment: .leading) {
      if description.wrappedValue == "" {
        TextEditor(text: .constant("신림동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"))
          .foregroundColor(.gray)
          .disabled(true)
      }
      
      TextEditor(text: description)
        .opacity(description.wrappedValue.isEmpty ? 0.25 : 1)
    }
  }
  
}

