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
    @State private var isFavorited = false
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
                    Text("Instructions")
                    
                    
                
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
}

struct DessertRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        DessertRecipeView(mealID: "52893")
    }
}
