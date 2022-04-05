//
//  MockSession.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 05/04/2022.
//

import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}

final class MockSession: AlamofireSession {
    
    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        
        let dataResponse = AFDataResponse<Any>(
            request: nil,
            response: fakeResponse.response,
            data: fakeResponse.data,
            metrics: nil,
            serializationDuration: 0,
            result: .success("Done"))
        
        completionHandler(dataResponse)
    }
    
    func encode(with baseURL: URL, and parameters: [(String, String)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseURL
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = urlComponents.url else { return baseURL }
        return url
    }
}
