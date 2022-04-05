//
//  EdanamRecipe.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 24/01/2022.
//

import Foundation

// MARK: - Welcome
struct EdamamResponse: Codable {
    let from, to, count: Int?
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?

    enum CodingKeys: String, CodingKey {
        case recipe
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: Title?
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String?
    let image: String?
    let url: String?
    let yield: Int?
    let ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let totalTime: Int?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory: String?
    let foodID: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
