//
//  API.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/26/25.
//

import Foundation


struct Country: Codable {
    let rates: [String: Double]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        
        // Extract the first key dynamically (e.g., "jpy" or "usd")
        let firstKey = container.allKeys.first?.stringValue ?? ""
        
        // Decode the rates under that key
        rates = try container.decode([String: Double].self, forKey: DynamicKey(stringValue: firstKey)!)
    }
}

// Custom key decoding strategy for dynamic keys
struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}


/*
struct Date: Codable {
    let date: [String: String]
}
*/

class API: ObservableObject {
    @Published var rates: [String: Double] = [:]
    //@Published var date: [String: String] = [:]

    func fetchRates(for baseCurrency: String) {
        guard let url = URL(string: "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/\(baseCurrency).json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Country.self, from: data)
                
                DispatchQueue.main.async {
                    self.rates = decodedResponse.rates
                }
                print(decodedResponse.rates)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
