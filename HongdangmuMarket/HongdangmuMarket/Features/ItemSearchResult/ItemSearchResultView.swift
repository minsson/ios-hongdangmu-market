//
//  ItemSearchResultView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/23.
//

import SwiftUI

struct ItemSearchResultView: View {
  
  var searchValue: String
  
  var body: some View {
    ItemListView(viewModel: ItemListViewModel(searchValue: searchValue))
  }
  
}

struct ItemSearchResultView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemSearchResultView(searchValue: "애플")
  }
  
}
