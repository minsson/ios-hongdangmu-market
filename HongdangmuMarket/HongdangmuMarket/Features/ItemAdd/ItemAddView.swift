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
    }
    
}

fileprivate struct ImagePickerView: View {
    
    @ObservedObject var viewModel: ItemAddViewModel
    
    var body: some View {
        imageAddButton
    }
    
}

private extension ImagePickerView {
    
    var imageAddButton: some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor.systemGray4))
                    .frame(width: 75, height: 75)
                
                Image(systemName: "camera.fill")
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.title3)
            }
        }
    }
    
}

struct ItemAddView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemAddView()
    }
    
}
