//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Aurelien Waxin on 24/01/2022.
//

import XCTest
@testable import Reciplease

class CoreDataManagerTests: XCTestCase {
    
    var coreDataStack : MockCoreDataStack!
    var coreDataManager : CoreDataManager!
    
//    let bundle = Bundle.init(for: CoreDataManagerTests.self)
//    let imageTest = UIImage(named: "recipeImage", in: bundle , compatibleWith: nil)
    let imageTest = "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6".data(using: .utf8)
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    func testAddFirstRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createRecipe(title: "recipe", ingredients: ["chicken","lemon"], yield: "3", totalTime: "10", image: imageTest! , url: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6")
        
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "recipe")
        XCTAssertTrue(coreDataManager.recipes[0].ingredients == ["chicken","lemon"])
        XCTAssertTrue(coreDataManager.recipes[0].yield == "3")
        XCTAssertTrue(coreDataManager.recipes[0].totalTime == "10")
        XCTAssertTrue(coreDataManager.recipes[0].imageData == imageTest)
        XCTAssertTrue(coreDataManager.recipes[0].url == "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6")
//        Check if favorite
        XCTAssertTrue(coreDataManager.checkIfRecipeIsFavorite(recipeTitle: "recipe", url: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6"))
        
//        DeleteRecipe
        coreDataManager.deleteRecipe(recipeTitle: "recipe", url: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6")
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
    }
    
    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createRecipe(title: "MyRecipe", ingredients: ["Ingredients"], yield: "16", totalTime: "0", image: imageTest! , url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "MyRecipe")
        XCTAssertTrue(coreDataManager.recipes[0].ingredients == ["Ingredients"])
        XCTAssertTrue(coreDataManager.recipes[0].yield == "16")
        XCTAssertTrue(coreDataManager.recipes[0].totalTime == "0")
        XCTAssertTrue(coreDataManager.recipes[0].imageData == imageTest)
        XCTAssertTrue(coreDataManager.recipes[0].url == "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(coreDataManager.checkIfRecipeIsFavorite(recipeTitle: "MyRecipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html"))
        coreDataManager.deleteAllRecipes()
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
        XCTAssertFalse(coreDataManager.checkIfRecipeIsFavorite(recipeTitle: "MyRecipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html"))
        }
    
    func testAddRecipeMethods_WhenAnEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
      
        XCTAssertFalse(coreDataManager.checkIfRecipeIsFavorite(recipeTitle: "Bloubiboulga", url: "www.casimir.com"))
    }
    

}
