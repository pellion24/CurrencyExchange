//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/24/25.
//

import SwiftUI




struct ContentView: View {
    @StateObject private var viewModel = API()

    @State private var countryNames = ["USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD", "BRR", "INR"]
    @State private var countryFlags = ["usd", "eur", "gbp", "jpy", "chf", "cad", "aud", "nzd", "brr", "inr"]

    var body: some View {
        NavigationView {
            VStack {
                Text("Select your country")
                List(countryNames, id: \.self) { country in
                    NavigationLink(destination: ExchangeRateView(currency: "USD", rate: viewModel.rates["usd"] ?? 0.0)) {
                        HStack {
                            Text(country)
                            Spacer()
                            Image(country.lowercased())
                                .resizable()
                                .frame(width: 40, height: 30)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchRates()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}




