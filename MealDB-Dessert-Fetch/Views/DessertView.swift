//
//  ContentView.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import SwiftUI

struct DessertView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = DessertViewModel()
    
    
    // MARK: - Body
    var body: some View {
        
        NavigationStack {
            List(viewModel.filterDesserts, id: \.id) { item in
                
                NavigationLink {
                    DessertRecipeView(mealID: item.id)
                } label: {
                    HStack {
                        CachedImageView(url: item.imageURLString)
                            .frame(width: 100, height: 100)

                        Text(item.dessertName)
                            .font(.headline)
                    }
                }
            }
            .listStyle(.inset)
            .task {
                try? await viewModel.getDesserts()
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Desserts")
        }
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}
