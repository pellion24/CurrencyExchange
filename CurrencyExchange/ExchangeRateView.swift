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
    let base: String
    
    @State private var amount: Double = 100.0

    var body: some View {
        ZStack {
            //Image("travelBackground")
                //.opacity(0.3)
            VStack {
                HStack {
                    Text(String(format: "%.2f", (amount)) + " \(base)")
                    Image(base.lowercased())
                        .resizable()
                        .frame(width: 32, height: 22)
                }
                Slider(value: $amount, in: 0...1000)
                let total = (amount * rate * 100).rounded() / 100
                HStack {
                    Text("You have \(String(format: "%.2f", total)) \(currency)")
                    Image(currency.lowercased())
                        .resizable()
                        .frame(width: 32, height: 22)
                    
                }
                    Text("\(currency) Exchange Rate")
                        .font(.title)
                        .padding()
                
                Text("1 \(base) = \(rate, specifier: "%.2f") \(currency)")
                    .font(.largeTitle)
                    .background(Color.yellow)
                    .clipShape(Capsule())
                    
                    .padding()
                
                
            }
            
        }
    }
}

#Preview {
    ExchangeRateView(currency: "USD", rate: 6.0, base: "credits")
}
