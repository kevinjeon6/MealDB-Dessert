//
//  ContentView.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import SwiftUI

struct DessertView: View {
    
    @StateObject var viewModel = DessertViewModel()
    
    var body: some View {
        
        NavigationStack {
            List(viewModel.dessertItem?.meals ?? [], id: \.id) { item in
                
                HStack {
                    AsyncImage(url: URL(string: item.imageURLString)) { phase in
                        
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        } else if phase.error != nil {
                            Text("Couldn't upload")
                        } else {
                            ProgressView()
                        }
                    }

                    Text(item.dessertName)
                }
                
            }
            .listStyle(.inset)
            .task {
                try? await viewModel.getDesserts()
            }
            .navigationTitle("Desserts")
        }
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}
