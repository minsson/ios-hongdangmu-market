//
//  View+Extension.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/29.
//

import SwiftUI

extension View {
  
  func errorAlert<E: LocalizedError>(error: Binding<E?>, buttonTitle: String = "알겠어요 ☺️") -> some View {
    let localizedError = error.wrappedValue
    return alert(isPresented: .constant(localizedError != nil), error: localizedError) { _ in
      Button(buttonTitle) {
        error.wrappedValue = nil
      }
    } message: { error in
      Text(error.recoverySuggestion ?? "")
    }
  }
  
  func keyboardToolbar(focus: FocusState<Bool>.Binding) -> some View {
    self
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()

            Button {
              focus.wrappedValue = false
            } label: {
              Image(systemName: "keyboard.chevron.compact.down.fill")
                .foregroundColor(.orange)
            }
        }
      }
  }
  
}
