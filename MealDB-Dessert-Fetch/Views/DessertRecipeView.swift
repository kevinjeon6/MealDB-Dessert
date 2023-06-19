//
//  DessertRecipeView.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/19/23.
//

import SwiftUI

struct DessertRecipeView: View {
    
    // MARK: - Properties
    @StateObject var recipeViewModel = RecipeViewModel()
    let mealID: String
    
    
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            ForEach(recipeViewModel.recipes?.meals ?? [], id: \.idMeal) { meal in
                VStack(alignment: .leading) {
                    Text(meal.strMeal ?? "")
                    Text(meal.strInstructions)
                }
            }
        }
        .task {
            try? await recipeViewModel.getRecipeDetails(for: mealID)
        }
    }
}

struct DessertRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        DessertRecipeView(mealID: "52893")
    }
}
