//
//  CachedImageView.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import SwiftUI

struct CachedImageView: View {
    
    // MARK: - Properties
    @StateObject private var imageManager = CachedImageManager()
    
    let url: String
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let data = imageManager.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } else {
                Text("Couldn't upload image")
                    .frame(width: 100, height: 100)
            }
        }
        .task {
            await imageManager.load(url)
        }
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(url: "https://www.themealdb.com/images/media/meals/rpvptu1511641092.jpg")
    }
}
