//
//  MealError.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation


enum MealError: Error {
    
    case invalidURL
    case serverError
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "This is a bad URL"
        case .serverError:
            return "Error while fetching the data"
        case .invalidData:
            return "Invalid data retreiving data"
        }
    }
}
