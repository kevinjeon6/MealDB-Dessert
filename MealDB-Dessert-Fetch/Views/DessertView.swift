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
            
            //Provide message that if the dessert that they are searching is not there, it will display 'Nothing here'
            //If there is a dessert or when they are typing. Display the list of desserts
            if !viewModel.filterDesserts.isEmpty {
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
            } else {
                Text("Nothing here")
            }
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .navigationTitle("Desserts")
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}
