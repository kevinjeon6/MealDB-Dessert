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
        ScrollView(showsIndicators: false) {
            ForEach(recipeViewModel.recipes?.meals ?? [], id: \.idMeal) { meal in
                VStack(alignment: .leading, spacing: 10) {
                    Text(meal.strMeal ?? "")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                    CachedImageView(url: meal.strMealThumb)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        Divider()
                    Text("Instructions")
                        .font(.headline)
                
                    Text(meal.strInstructions)
                    
                    Divider()
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(meal.ingredients.indices, id: \.self) { index in
                        HStack {
                            Text("\(meal.ingredients[index])")
                            Spacer()
                            Text("\(meal.measurements[index])")
                        }

                    }
                }
                .padding(.horizontal)
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
