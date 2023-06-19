//
//  DessertViewModel_Tests.swift
//  MealDB-Dessert-Fetch_Tests
//
//  Created by Kevin Mattocks on 6/19/23.
//

import XCTest
@testable import MealDB_Dessert_Fetch

//Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
//Define test cases. Always start with the name "test"

//Naming Structure: test_[struct or class]_[variable or function]_[expected result of variable or function]
//Testing Structure: Given, When, Then

final class DessertViewModel_Tests: XCTestCase {
    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func test_DessertViewModel_endpoint_requestDessert_isValid() async throws {
        //Given
        let viewModel = DessertViewModel()
        //When
        let expectation = XCTestExpectation(description: "Fetch desserts")
       //Then
        Task {
            do {
                //Verifying that the response is not nil
                try await viewModel.getDesserts()
                XCTAssertNotNil(viewModel.dessertItem)
                XCTAssertTrue(viewModel.dessertItem?.meals.count ?? 0 > 0)
            } catch {
                //If nil, test will fail
                XCTFail("Failed to fetch desserts: \(error)")
            }
            
            expectation.fulfill()
        }
      
    }
    
    
    //Testing to make sure that Apam balik is the first item of the dessert meals
    @MainActor func test_DessertViewModel_firstDessertItem_request_isValid() async throws {
        //Given
        let viewModel = DessertViewModel()

        //When
        let actual = viewModel.dessertItem?.meals.first?.dessertName ?? "Apam balik"
        let expected = "Apam balik"
        //Then
        //Comparing two items that are the same
        XCTAssertEqual(actual, expected)
  
      
    }
    
    
    
    @MainActor func test_RecipeViewModel_endpoint_request_isValid() async throws {
        let recipeViewModel = RecipeViewModel()
        
        let expectation = XCTestExpectation(description: "Fetch dessert recipes")
       
        Task {
            do {
                try await recipeViewModel.getRecipeDetails(for: "53049")
            } catch {
                XCTFail("Failed to fetch desserts: \(error)")
            }
            expectation.fulfill()
        }
    }
    
    
    //Testing to make sure that idMeal is the first meal ID for the recipe of the dessert meals
    @MainActor func test_RecipeViewModel_endpoint_requestMealID_isValid() async throws {
        let recipeViewModel = RecipeViewModel()
        
        let expectation = XCTestExpectation(description: "Fetch dessert recipes")
        let actual = recipeViewModel.recipes?.meals.first?.idMeal ?? "53049"
        let expected = "53049"
        XCTAssertEqual(actual, expected)

    }
    
    


}
