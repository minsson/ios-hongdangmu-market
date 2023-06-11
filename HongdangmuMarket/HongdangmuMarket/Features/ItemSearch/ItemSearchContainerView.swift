//
//  ItemSearchContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/19.
//

import SwiftUI

struct ItemSearchContainerView: View {
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var isKeyboardFocused: Bool
  @StateObject private var viewModel = ItemSearchViewModel()
  
  private let gridColumns: [GridItem] = [
    GridItem(.flexible(), spacing: 32),
    GridItem(.flexible())
  ]
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.bottom)
      
      switch viewModel.searchPhase {
      case .recentSearchWords:
        recentSearchWords
      case .suggestionWords:
        suggestionWordsContainer
      case .listBySearchValue:
        ItemSearchResultView(searchValue: viewModel.searchBarText)
      }
      
      Spacer()
    }
    .padding()
    .navigationBarBackButtonHidden()
    .errorAlert(error: $viewModel.error)
    .focused($isKeyboardFocused)
    .keyboardToolbar(focus: $isKeyboardFocused)
  }
  
}

private extension ItemSearchContainerView {
  
  var navigationBar: some View {
    HStack {
      backButton
        .padding(.trailing, 6)
      
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
        .onChange(of: viewModel.searchBarText) { _ in
          viewModel.searchBarTextWasChanged()
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
          isKeyboardFocused = false
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
  }
  
  func recentSearchWord(_ word: String) -> some View {
    VStack {
      HStack {
        Button {
          viewModel.recentSearchWordTapped(word: word)
          isKeyboardFocused = false
        } label: {
          Text(word)
            .foregroundColor(.primary)
            .lineLimit(1)
        }
        
        Spacer()
        
        Button {
          viewModel.deleteOneSearchWordButtonTapped(word)
          isKeyboardFocused = false
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
  
  var suggestionWordsContainer: some View {
    VStack {
      ForEach(viewModel.suggestionWords, id: \.self) { word in
        suggestionWord(word)
          .padding(.bottom)
      }
    }
  }
  
  func suggestionWord(_ word: String) -> some View {
    Button {
      viewModel.suggestionWordTapped()
      isKeyboardFocused = false
    } label: {
      HStack {
        Image(systemName: "magnifyingglass")
          .font(.callout)
          .padding(.trailing, 6)
        
        Text(word)
      }
      .foregroundColor(.primary)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
}

struct ItemSearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemSearchContainerView()
  }
  
}
