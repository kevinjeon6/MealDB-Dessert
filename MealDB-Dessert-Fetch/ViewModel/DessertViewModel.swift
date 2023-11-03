//
//  DessertViewModel.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation


@MainActor
class DessertViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var dessertItem: DessertResponse?
    @Published var searchText = ""
    
    var filterDesserts: [DessertMeal] {
        if searchText.isEmpty {
            return dessertItem?.meals ?? []
        } else {
            return dessertItem?.meals.filter { $0.dessertName.localizedCaseInsensitiveContains(searchText)} ?? []
        }
    }
    
    
    init(){
        Task {
            self.dessertItem = try await DessertNetworkManager.getDesserts()
        }
    }
        
    
}
