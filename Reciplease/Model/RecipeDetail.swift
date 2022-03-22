//
//  RecipeData.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 10/03/2022.
//

import Foundation

struct RecipeDetail {
    let title: String
    let imageData: Data?
    let ingredients: [String]
    let url: String
    let yield: String
    let totalTime: String
}
