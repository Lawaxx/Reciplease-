//
//  FakeResponseData.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 05/04/2022.
//

import Foundation


class FakeResponseData {
    static let url: URL = URL(string: "https://api.edamam.com/api/recipes/v2?")!
    static let responseOK = HTTPURLResponse(url: URL(string: "https://api.edamam.com/api/recipes/v2?")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://networkcalc.com/api/binary/1101111")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}
