//
//  DessertRecipe.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation

struct DessertRecipeResponse: Codable {
    
    var meals: [RecipeDetails]
}

struct RecipeDetails: Codable {
    
    var idMeal: String
    var strMeal: String?
    var strInstructions: String
    var strMealThumb: String
    
    //Create properties for ingredients and measurements
    var ingredients: [String]
    var measurements: [String]

    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?

    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    
    
    enum CodingKeys: String, CodingKey {

         case id = "idMeal"
         case dessertMealName = "strMeal"
         case instructions = "strInstructions"
         case imageURLString = "strMealThumb"

        
         case ingredient1 = "strIngredient1"
         case ingredient2 = "strIngredient2"
         case ingredient3 = "strIngredient3"
         case ingredient4 = "strIngredient4"
         case ingredient5 = "strIngredient5"
         case ingredient6 = "strIngredient6"
         case ingredient7 = "strIngredient7"
         case ingredient8 = "strIngredient8"
         case ingredient9 = "strIngredient9"
         case ingredient10 = "strIngredient10"
         case ingredient11 = "strIngredient11"
         case ingredient12 = "strIngredient12"
         case ingredient13 = "strIngredient13"
         case ingredient14 = "strIngredient14"
         case ingredient15 = "strIngredient15"
         case ingredient16 = "strIngredient16"
         case ingredient17 = "strIngredient17"
         case ingredient18 = "strIngredient18"
         case ingredient19 = "strIngredient19"
         case ingredient20 = "strIngredient20"

         case measurement1 = "strMeasure1"
         case measurement2 = "strMeasure2"
         case measurement3 = "strMeasure3"
         case measurement4 = "strMeasure4"
         case measurement5 = "strMeasure5"
         case measurement6 = "strMeasure6"
         case measurement7 = "strMeasure7"
         case measurement8 = "strMeasure8"
         case measurement9 = "strMeasure9"
         case measurement10 = "strMeasure10"
         case measurement11 = "strMeasure11"
         case measurement12 = "strMeasure12"
         case measurement13 = "strMeasure13"
         case measurement14 = "strMeasure14"
         case measurement15 = "strMeasure15"
         case measurement16 = "strMeasure16"
         case measurement17 = "strMeasure17"
         case measurement18 = "strMeasure18"
         case measurement19 = "strMeasure19"
         case measurement20 = "strMeasure20"

     }
    
}


// MARK: - Extension for RecipeDetails

extension RecipeDetails {
    
    //Decoder contains all our data but we need to figure out how to read it
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .id) //the forKey: is looking for the exact key in CodingKeys
        strMeal = try container.decode(String.self, forKey: .dessertMealName)
        strInstructions = try container.decode(String.self, forKey: .instructions)
        strMealThumb = try container.decode(String.self, forKey: .imageURLString)
        
        //Store the ingredients and measurements into an array.
        self.ingredients = []
        self.measurements = []
        
        try (1...20).forEach { index in
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(index)") ?? .ingredient1
            let measurementKey = CodingKeys(rawValue: "strMeasure\(index)") ?? .measurement1
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measurement = try container.decodeIfPresent(String.self, forKey: measurementKey),
               !ingredient.isEmpty, !measurement.isEmpty {
                self.ingredients.append(ingredient)
                self.measurements.append(measurement)
            }
            
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .id) //the forKey: is looking for the exact key in CodingKeys
        try container.encode(strMeal, forKey: .dessertMealName)
        try container.encode(strInstructions, forKey: .instructions)
        try container.encode(strMealThumb, forKey: .imageURLString)
        
        
        // Encode the ingredients array
         for index in 0..<ingredients.count {
             guard let ingredientKey = CodingKeys(rawValue: "strIngredient\(index + 1)") else { return }
             try container.encode(ingredients[index], forKey: ingredientKey)
         }

         // Encode the measurements array
         for index in 0..<measurements.count {
             guard let measurementKey = CodingKeys(rawValue: "strMeasure\(index + 1)") else { return }
             try container.encode(measurements[index], forKey: measurementKey)
         }
     }
}
    

