//
//  ItemSearchView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/19.
//

import SwiftUI

struct ItemSearchView: View {
  
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = ItemSearchViewModel()
  
  var body: some View {
    ZStack {
      Color(.systemBackground)
      
      navigationBar
        .padding()
        .navigationBarBackButtonHidden()
    }
  }
  
}

private extension ItemSearchView {
  
  var navigationBar: some View {
    HStack {
      backButton
      
      searchBar
        .frame(maxWidth: .infinity)
    }
  }
  
  var backButton: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "chevron.left")
    }
    .foregroundColor(.black)
  }
  
  var searchBar: some View {
    HStack {
      TextField("신림동 근처에서 검색", text: $viewModel.searchBarText)
        .foregroundColor(.primary)
      
      if viewModel.shouldPresentTextDeletionButton {
        Button {
          viewModel.textDeletionButtonTapped()
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(Color(.systemGray2))
        }
      }
    }
    .padding(.horizontal)
    .padding(.vertical, 8)
    .background { Color(.secondarySystemBackground) }
    .cornerRadius(8)
  }
  
}

struct ItemSearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemSearchView()
  }
  
}
