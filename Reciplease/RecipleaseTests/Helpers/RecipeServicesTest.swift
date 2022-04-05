//
//  RecipeServicesTest.swift
//  RecipleaseTests
//
//  Created by Aurelien Waxin on 05/04/2022.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeServicesTest: XCTestCase {
    
    // MARK: - Properties
    
    var ingredientsList: [String]!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        ingredientsList = ["Chicken", "Lemon"]
    }
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests

    func testsFetchBinaryConvertion_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseData.url: (nil, nil, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: EdamamService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getRecipe(ingredientsList: ingredientsList.joined()) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .dataError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

//    func testsFetchBinaryConvertion_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
//        URLProtocolFake.fakeURLs = [FakeResponseData.url: (FakeResponseData.correctData, FakeResponseData.responseKO, nil)]
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: EdamamService = .init(edamamSession: fakeSession as! AlamofireSession )
//
//        let expectation = XCTestExpectation(description: "Waiting...")
//        sut.getRecipe(ingredientsList: ingredientsList.joined()) { result in
//            guard case .failure(let error) = result else {
//                XCTFail("Test failed: \(#function)")
//                return
//            }
//            XCTAssertTrue(error == .invalidResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }

//    func testsFetchBinaryConvertion_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
//        URLProtocolFake.fakeURLs = [FakeResponseData.url: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: BinaryNetworkService = .init(session: fakeSession)
//
//        let expectation = XCTestExpectation(description: "Waiting...")
//        sut.fetchBinaryConvertion(binary: "1101111") { result in
//            guard case .failure(let error) = result else {
//                XCTFail("Test failed: \(#function)")
//                return
//            }
//            XCTAssertTrue(error == .undecodableData)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testsFetchBinaryConvertion_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
//        URLProtocolFake.fakeURLs = [FakeResponseData.url: (FakeResponseData.correctData, FakeResponseData.responseOK, nil)]
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: BinaryNetworkService = .init(session: fakeSession)
//
//        let expectation = XCTestExpectation(description: "Waiting...")
//        sut.fetchBinaryConvertion(binary: "1101111") { result in
//            guard case .success(let number) = result else {
//                XCTFail("Test failed: \(#function)")
//                return
//            }
//            XCTAssertTrue(number.converted == "111")
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//}

    
    // MARK: - Tests
//
//    func testGetRecipesShouldPostFailedCallback() {
//        URLProtocolFake.fakeURLs
//        let fakeResponse = FakeResponseData
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfNoData() {
//        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndDataNil() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//            XCTAssertTrue(success)
//            XCTAssertNotNil(recipesSearch)
//            XCTAssertEqual(recipesSearch?.hits[0].recipe.label, "Recreating the Adult Brownies from Andronico's Recipe")
//            XCTAssertEqual(recipesSearch?.hits[0].recipe.image, "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg")
//            XCTAssertEqual(recipesSearch?.hits[0].recipe.yield, Int(16.0))
//            XCTAssertEqual(recipesSearch?.hits[0].recipe.url, "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
}
