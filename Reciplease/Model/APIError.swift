//
//  APIError.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 25/01/2022.
//

import Foundation

enum APIError: Error {
    case dataError
    case invalidResponse
    case decodeError 
}
