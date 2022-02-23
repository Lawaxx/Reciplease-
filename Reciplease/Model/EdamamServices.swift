//
//  EdanamServices.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 25/01/2022.
//

import Foundation
import Alamofire

class EdamamService  {
    
    static var shared = EdamamService()
//    private let session: URLSession
    private let edamamUrl = "https://api.edamam.com/api/recipes/v2"
    
    private let session : AlamofireSession
    
    init(edamamSession: AlamofireSession = EdamamSession()){
        self.session = edamamSession
    }
    
    func getRecipe(ingredientsList: String , completionHandler: @escaping (Result<EdamamResponse,APIError>) -> Void){
        guard let baseURL = URL(string: "https://api.edamam.com/api/recipes/v2") else { return }
        let parameters : [(String,String)] = [("type","public"),("q", ingredientsList),("app_id",APIKeys.edamamAppID),("app_key", APIKeys.edamamAPI)]
        let url = session.encode(with: baseURL, and: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.request(url: url) { responseData in
            
                guard let data = responseData.data else {
                    completionHandler(.failure(.dataError))
                    return
                }
                
                guard responseData.response?.statusCode == 200 else {
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                guard let responseJson = try? JSONDecoder().decode(EdamamResponse.self, from: data) else {
                    completionHandler(.failure(.decodeError))
                    return
                }
                completionHandler(.success(responseJson))
//                print(responseJson)
            }
        }
    }
