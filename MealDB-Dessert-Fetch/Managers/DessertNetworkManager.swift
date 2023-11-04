//
//  DessertNetworkManager.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 11/3/23.
//

import Foundation


class DessertNetworkManager {
    
    //Static. Can call this function/method without making an instance
    //Static keyword is creating a type constant
    static func getDesserts() async throws -> DessertResponse? {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { throw MealError.invalidURL }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw MealError.serverError }
            
            let decoder = JSONDecoder()
            let decodedDessert = try decoder.decode(DessertResponse.self, from: data)
            return decodedDessert
            
            
        } catch {
            throw MealError.invalidData
        }
    }
    
}
