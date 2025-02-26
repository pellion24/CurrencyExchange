//
//  API.swift
//  CurrencyExchange
//
//  Created by Ashvij Hosdurg on 2/26/25.
//

import Foundation


struct Country: Codable {
    let jpy: [String: Double]
}


/*
struct Date: Codable {
    let date: [String: String]
}
*/

class API: ObservableObject {
    @Published var rates: [String: Double] = [:]
    //@Published var date: [String: String] = [:]

    func fetchRates() {
        guard let url = URL(string: "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/jpy.json") else {
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
                    self.rates = decodedResponse.jpy
                }
                print(decodedResponse.jpy)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
