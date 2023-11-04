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
    
    //Persisting the favorite button data using AppStorage
    @AppStorage("favorite") var favoriteMeal: String?
    let mealID: String
    
    
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(recipeViewModel.recipes?.meals ?? [], id: \.idMeal) { meal in
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(meal.strMeal ?? "")
                        .frame(maxWidth: .infinity)
                    
                    CachedImageView(url: meal.strMealThumb)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                    
                    
                    Divider()
                    HStack {
                        Text("Instructions")
                        Spacer()
                        Button {
                            toggleFave(for: meal)
                        } label: {
                            Image(systemName: isfavorite(for: meal) ? "heart.fill" : "heart")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    
                
                    Text(meal.strInstructions)
                        .font(.body)
                    
                    Divider()
             
                    Text("Ingredients")
                   
                    //Looping over the array of ingredients list array
                    //Need to +1 since collection starts at 0
                    //ingredients[index] accesses the element within the array.
                    ForEach(meal.ingredients.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1). \(meal.ingredients[index])")
                            Spacer()
                            Text("\(meal.measurements[index])")
                        }
                        .font(.body)

                    }
                }
                .font(.headline)
                .padding(.horizontal)
            }
        }
        .task {
            try? await recipeViewModel.getRecipeDetails(for: mealID)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: - Methods
    
    //Function to see if recipe is favorited already or not
    private func isfavorite(for meal: RecipeDetails) -> Bool {
        return meal.idMeal == favoriteMeal
    }
    
    
    //Function to toggle favorite recipe
    private func toggleFave(for meal: RecipeDetails) {
        let mealID = meal.idMeal
        
        if isfavorite(for: meal) {
            favoriteMeal = nil
            //If favorited already then dont return anything
        } else {
            favoriteMeal = mealID
            //If it hasn't been favorited. Then add it to favorites
        }
    }
}

struct DessertRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        DessertRecipeView(mealID: "52893")
    }
}
