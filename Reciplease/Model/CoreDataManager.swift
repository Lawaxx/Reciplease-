//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 25/02/2022.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createRecipe(title: String, ingredients: [String], yield: String, totalTime: String, image: Data, url: String) {
        let recipe = RecipeEntity(context: managedObjectContext)
                recipe.title = title
                recipe.ingredients = ingredients
                recipe.yield = yield
                recipe.totalTime = totalTime
                recipe.imageData = image
                recipe.url = url
        coreDataStack.saveContext()
    }
//    updateStarFavorite

    func deleteAllRecipes() {
        recipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteRecipe(recipeTitle: String, url: String) {
            let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@", recipeTitle)
            request.predicate = NSPredicate(format: "url == %@", url)

            if let entity = try? managedObjectContext.fetch(request) {
                entity.forEach { managedObjectContext.delete($0) }
            }
            coreDataStack.saveContext()
        }
    
    func checkIfRecipeIsFavorite(recipeTitle: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
                request.predicate = NSPredicate(format: "title == %@", recipeTitle)
                request.predicate = NSPredicate(format: "url == %@", url)
                
                guard let counter = try? managedObjectContext.count(for: request) else { return false }
        if counter == 0 {
            return false }
        else {
            return true
        }
    }
}

