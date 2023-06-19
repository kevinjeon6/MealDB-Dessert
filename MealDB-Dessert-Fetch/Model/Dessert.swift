//
//  Dessert.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation

struct DessertResponse: Codable {
    
    var meals: [DessertMeal]
}

struct DessertMeal: Codable {
    
    var dessertName: String
    var imageURLString: String
    var id: String
    
    
    //Using CodingKeys and mapping the keys to the JSON
    
    enum CodingKeys: String, CodingKey {
        case dessertName = "strMeal"
        case imageURLString = "strMealThumb"
        case id = "idMeal"
    }
    
    static let mealExample = DessertMeal(dessertName: "Blackberry Fool", imageURLString: "https://www.themealdb.com/images/media/meals/rpvptu1511641092.jpg", id: "52893")
}
