//
//  ExchangeRateView.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/26/25.
//

import SwiftUI

// New View to Show Exchange Rates
struct ExchangeRateView: View {
    let currency: String
    let rate: Double

    var body: some View {
        VStack {
            Text("\(currency) Exchange Rate")
                .font(.title)
                .padding()
            Text("1 JPY = \(rate, specifier: "%.4f") \(currency)")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    ExchangeRateView(currency: "usd", rate: 6.0)
}
