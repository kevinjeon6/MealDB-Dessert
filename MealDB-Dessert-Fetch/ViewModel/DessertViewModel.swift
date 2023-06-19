//
//  DessertViewModel.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation


@MainActor
class DessertViewModel: ObservableObject {
    
    @Published var dessertItem: DessertResponse?
    
    
    func getDesserts() async throws {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { throw MealError.invalidURL }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw MealError.serverError }
            
            let decoder = JSONDecoder()
            self.dessertItem = try decoder.decode(DessertResponse.self, from: data)
            
        } catch {
            print("Error. Something went wrong\n\(error)")
        }
    }
    
    
}
