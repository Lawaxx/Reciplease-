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
        ingredientsList = ["Chicken"]
    }
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests

    func testRecipeService_ShouldPostFailedCallBack_IfNoData_And_NoResponse() {
            // Given
            let session = MockSession(fakeResponse: FakeResponse(response: nil, data: nil, error: nil))
            let recipeService = EdamamService(edamamSession: session)
            
            // When
            let expectation = expectation(description: "Wait for queue changing.")
            recipeService.getRecipe(ingredientsList: "Chicken") { (result) in
                // Then
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testRecipeService_ShouldPostFailedCallBack_IfIncorrectResponse() {
           // Given
        let session = MockSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
           let recipeService = EdamamService(edamamSession: session)
           
           // When
           let expectation = expectation(description: "Wait for queue changing.")
           recipeService.getRecipe(ingredientsList: "Chicken") { (result) in
               //then
               XCTAssertNotNil(result)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 0.01)
       }
       
     
       // MARK: - ❌ Failed: Incorrect Datas
       func testRecipeService_ShouldPostFailedCallBack_IfIncorrectDatas() {
           // Given
           let session = MockSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
           let recipeService = EdamamService(edamamSession: session)
           
           // When
           let expectation = expectation(description: "Wait for queue changing.")
           recipeService.getRecipe(ingredientsList: "Chicken") { (result) in
               //then
               XCTAssertNotNil(result)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 0.01)
       }
    // MARK: - ✅ Success : Correct datas and correct responses
        func testRecipeService_ShouldPostSuccessCallBack_IfCorrectData_And_ResponseOK() {
            // Given
            let session = MockSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
            let recipeService = EdamamService(edamamSession: session)
            
            // When
            let expectation = expectation(description: "Wait for queue changing.")
            recipeService.getRecipe(ingredientsList: "Chicken") { (result) in
                //then
                guard case .success(let data) = result else {
                    XCTFail("Test getRecipes method with correct data failed.")
                    return
                }
                
                XCTAssertNotNil(result)
                self.testJsonDataCorrespondToExpectedResult(data: data)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
        }
        
        
        // MARK: - Private method
        
        private func testJsonDataCorrespondToExpectedResult(data: EdamamResponse) {
            let title = "Chicken Cordon Bleu"
            let imageUrl = "https://edamam-product-images.s3.amazonaws.com/web-img/c96/c9627c8fc726b997956d64b569e512c0.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIDKYiQPqNfIcbg7CHuWvWZpPNc6BlsJlEDZmQ5h6e7mZAiEApqSDX69PqR%2BKCjvNiohsxjwXh5YCBjLacDEeVTmxTu0qgwQIlP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDFgGTkaL4mkq%2BZ9ebSrXA3styg05t8Nocu1ttXOAI9PipZeK%2F884L7STUsGvojoG0sU6Jvyfrbrh7CvF%2BvJK2JoMz1Mp58QvdxEdqZ8kampKZk33U%2FqaMX4nO1w4D45NrWkn36vN1cimfgkbB2YcK2m%2Fm6eqUbOYfYJGgjMPFqJ%2BwxeeDUhgI7tmKiwAm8HbuMXknUS50u263qfljejGgIm%2BzLr27jL4M1WMEFp035WJLKAEl0eqqPxmjqBzdIOR88umAvBgVAqPUMj0%2FhqPMvd60cl53CItx6hPvdmoN6mHbURO%2BBKZkK55iLf4v4im7JSBOhF5BfQoPGiMiQltpURZq9DPwy6hD3SALTXR0QavvETDWxgFWL5NmJ6Iy0ek7BeSHmQnDX2JUfN9alkSF0sdA%2B2bThN3Aj6As9gFcBpCMTKdbGjWbdVVIz1zT6jvRCrKLJ09L4GCIJgTxCeQHUchbvE%2FLIm%2B7Brvy2dv8R8L9wIl%2BF0EKvb0da%2BAlHT%2B%2FaAqYnaEHVOGZA6EVlm2R2Dl2ur5Kha%2BZYm3mmozGhtAK9O8le2KGP8HZ6XQYnb62Tk%2F946RQE4OpZLx5UB%2Bsyma%2BeiMqLLQZAkFA9RShPabRbKDNwXrXHyGjNmImn3nL9mX6o0ZFjDdqLKSBjqlAU%2Bj%2Fo5GXNQf4KhfjyTZlSGj8QSdV0SWPKDEi2W6t8lxryPRqwXRhGuau4T7P399uHT1lb8iyQqwatABqOGxN2YL7LE9KPjWidbxfNaV0RtOQuoZQdjOTS2y0bkVJIzhNhaXD4c%2FF3QpO0UHrBNl2QnactnljYI54tGnwy%2FkFKh8xkbOisnLrEhpNyWHxj3mPv3taXOfYHaB84pbdZhEXdjsijpKaA%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220405T194405Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFG7TSPLEQ%2F20220405%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=e2baae0ed5384732730b72e56a87061e47f3a243c2679e551ce18ee725ebfd47"
            let url = "http://kalynskitchen.blogspot.com/2007/04/recipe-update-easy-chicken-cordon-bleu.html"
            let yield = 6
            let ingredientLines = ["6 x chicken breasts",
                                   "12 x Canadian Bacon pieces",
                                   "6 oz Gruyere Cheese",
                                   "1/4 cup Chicken Stock",
                                   "1 tbsp Olive Oil",
                                   "1/2 tsp Poultry Seasoning"]
            let totalTime = 0
            
            XCTAssertEqual(data.hits![0].recipe?.label, title)
            XCTAssertEqual(data.hits![0].recipe?.image, imageUrl)
            XCTAssertEqual(data.hits![0].recipe?.url, url)
            XCTAssertEqual(data.hits![0].recipe?.yield, yield)
            XCTAssertEqual(data.hits![0].recipe?.ingredientLines, ingredientLines)
            XCTAssertEqual(data.hits![0].recipe?.totalTime, totalTime)
        }
    }
