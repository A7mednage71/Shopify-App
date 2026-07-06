//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Foundation
import SwiftUI

public struct CurrencyResponse: Codable {
    public let result: String
    public let baseCode: String
    public let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case result
        case baseCode = "base_code"
        case rates
    }
}

public class CurrencyService {
    public static let shared = CurrencyService()
    
    @AppStorage("exchangeRatesData") private var exchangeRatesData: Data = Data()
    
    private init() {}
    
    public func fetchLatestRates() async {
        guard let url = URL(string: "https://open.er-api.com/v6/latest/USD") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            
            if response.result == "success" {
                if let encodedRates = try? JSONEncoder().encode(response.rates) {
                    DispatchQueue.main.async {
                        self.exchangeRatesData = encodedRates
                    }
                }
            }
        } catch {
            print("Error fetching rates: \(error.localizedDescription)")
        }
    }
    
    public func getRate(for currencyCode: String) -> Double {
        guard let rates = try? JSONDecoder().decode([String: Double].self, from: exchangeRatesData),
              let rate = rates[currencyCode] else {
            return 1.0 
        }
        return rate
    }
}
