//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/24/25.
//

import SwiftUI




struct ContentView: View {
    @StateObject private var viewModel = API()
    @State private var baseCurrency = "USD"

    @State private var countryNames = ["USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD", "BRL", "INR"]
    @State private var countryFlags = ["usd", "eur", "gbp", "jpy", "chf", "cad", "aud", "nzd", "brl", "inr"]

    var body: some View {
        NavigationView {
            VStack {
                Text("Enter your base currency")
                
                
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
                Text("Select the country you are visiting")
                List(countryNames, id: \.self) { country in
                    NavigationLink(destination: ExchangeRateView(currency: country, rate: viewModel.rates[country.lowercased()] ?? 0.0, base: baseCurrency)) {
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
                viewModel.fetchRates(for: baseCurrency.lowercased())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}




