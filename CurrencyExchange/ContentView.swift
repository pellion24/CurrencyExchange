//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/24/25.
//

import SwiftUI




struct ContentView: View {
    @StateObject private var viewModel = API()
    @State private var baseCurrency = ""
    
    @State private var countryNames = ["USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD", "BRL", "INR"]
    @State private var countryFlags = ["usd", "eur", "gbp", "jpy", "chf", "cad", "aud", "nzd", "brl", "inr"]

    var body: some View {
        NavigationView {
            ZStack {
                //Image("travelBackground")
                    //.opacity(0.3)
                VStack {
                    Text("1. Enter your base currency (ALL CAPS)")
                        .font(.headline)
                    Text("It may take some time for API request to complete, first check if your currency is 1 to 1")
                        .font(.subheadline)
                        .fontWidth(.compressed)
                        
                    TextField("", text: $baseCurrency)
                        .onSubmit {
                            viewModel.fetchRates(for: baseCurrency.lowercased())
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
    
                    
                    Text("2. Select the country you are visiting")
                        .font(.headline)
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
                
            } //ZStack
        }
    }
}

#Preview {
    ContentView()
}




