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

    @MainActor func test_DessertViewModel_endpoint_request_isValid() {
        //Given
        let viewModel = DessertViewModel()
        //When
        let expectation = XCTestExpectation(description: "Fetch desserts")
        
        Task {
            do {
                try await viewModel.getDesserts()
                XCTAssertNotNil(viewModel.dessertItem)
            } catch {
                XCTFail("Failed to fetch desserts: \(error)")
            }
            
            expectation.fulfill()
        }
        //Then
        
        wait(for: [expectation], timeout: 2.0)
    }

}
