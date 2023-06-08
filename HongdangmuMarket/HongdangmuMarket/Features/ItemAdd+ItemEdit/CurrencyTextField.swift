//
//  CurrencyTextField.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/08.
//

import SwiftUI

struct CurrencyTextField: View {
  
  let placeholder: String
  let currency: Currency
  @Binding var text: String
  
  private let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    return formatter
  }()
  
  var body: some View {
    HStack {
      if !text.isEmpty {
        Text(currency.symbol)
      }
      
      TextField(placeholder, text: Binding(get: {
        return formattedText
      }, set: { newValue in
        text = newValue.filter { $0.isNumber }
      }))
      .keyboardType(.numberPad)
    }
    
  }
  
}

private extension CurrencyTextField {
  
  var formattedText: String {
    if let number = Int(text) {
      return currencyFormatter.string(from: number as NSNumber) ?? ""
    } else {
      return ""
    }
  }
  
}
