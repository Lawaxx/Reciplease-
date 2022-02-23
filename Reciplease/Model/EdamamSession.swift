//
//  EdamamSession.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void)
    func encode(with baseURL: URL, and parameters: [(String, String)]?) -> URL
    }
    
    
final class EdamamSession : AlamofireSession {
    
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            completionHandler(dataResponse)
        }
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
    
//    func encode(with baseURL: URL, and parameters: [(String, String)]) -> URL {
//        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { return baseURL }
//        urlComponents.queryItems = [URLQueryItem]()
//        for (key, value) in parameters {
//            let queryItem = URLQueryItem(name: key, value: value)
//            urlComponents.queryItems?.append(queryItem)
//        }
//        guard let url = urlComponents.url else { return baseURL }
//        return url
//    }
//}
