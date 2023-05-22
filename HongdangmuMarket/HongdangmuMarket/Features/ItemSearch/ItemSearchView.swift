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
  
  private let gridColumns: [GridItem] = [
    GridItem(.flexible(), spacing: 32),
    GridItem(.flexible())
  ]
  
  var body: some View {
    VStack {
      navigationBar
        .padding()
      
      if viewModel.hasSearchBarText {
        
      } else {
        recentSearchWords
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
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
        .onSubmit {
          viewModel.searchWordWasSubmitted(viewModel.searchBarText)
        }
      
      if viewModel.hasSearchBarText {
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
  
  var recentSearchWords: some View {
    VStack {
      HStack {
        Text("최근 검색어")
          .bold()
        
        Spacer()
        
        Button("모두 지우기") {
          viewModel.deleteRecentSearchWordsButtonTapped()
        }
        .foregroundColor(Color(UIColor.secondaryLabel))
      }
      .padding(.vertical)
      
      LazyVGrid(columns: gridColumns) {
        ForEach(viewModel.recentSearchWords, id: \.self) { word in
          recentSearchWord(word)
        }
      }
      
    }
    .padding(.horizontal)
  }
  
  func recentSearchWord(_ word: String) -> some View {
    VStack {
      HStack {
        Text(word)
          .lineLimit(1)
        
        Spacer()
        
        Button {
          viewModel.deleteOneSearchWordButtonTapped(word)
        } label: {
          Image(systemName: "xmark")
            .foregroundColor(.secondary)
        }
      }
      .padding(.vertical, 8)
      
      Rectangle()
        .frame(height: 1)
        .foregroundColor(Color(UIColor.tertiarySystemFill))
    }
  }
  
}

struct ItemSearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemSearchView()
  }
  
}
