//
//  EdanamRecipe.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 24/01/2022.
//

import Foundation

// MARK: - Welcome
struct EdamamResponse: Decodable {
    let from, to, count: Int
    let links: WelcomeLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
    let links: HitLinks

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Decodable {
    let linksSelf: Next

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Decodable {
    let href: String
    let title: Title
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String?
    let images: Images
    let source: String
    let url: String
    let yield: Int?
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int?
}
// MARK: - Images
struct Images: Decodable {
    let thumbnail, small, regular: Large
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct Large: Decodable {
    let url: String
    let width, height: Int
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String?
    let foodID: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
// MARK: - WelcomeLinks
struct WelcomeLinks: Decodable {
    let next: Next
}
