//
//  ImageRetriever.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation

//Cache images
//Prevent making unnecssary network requests when downloading an image using AsyncImage
//Images going on and off the screen will always get redownloaded. Making a lot of network requests.


//Building custom Async Image
struct ImageRetriever {
    //Pass in the image URL as a string
    //Throws means that something could go wrong
    func fetch(_ imgURL: String) async throws -> Data {
        
        //Make a network request
        guard let url = URL(string: imgURL) else { throw MealError.invalidURL }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return data
        
    }
}
