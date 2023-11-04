//
//  RecipeViewModel.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var recipes: DessertRecipeResponse?
    
    
    // MARK: - Methods
    
    func getRecipeDetails(for mealID: String) async throws {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { throw MealError.invalidURL}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw MealError.serverError}
            
            let decoder = JSONDecoder()
            self.recipes = try decoder.decode(DessertRecipeResponse.self, from: data)
            
            
        } catch {
            throw MealError.invalidData
        }
        
    }
    
}
