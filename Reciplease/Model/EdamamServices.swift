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
//    HREF pour next page -> tableview
    
    func loadMoreData(from: Int, to: Int, completionHandler: @escaping(Result<EdamamResponse,APIError>) -> Void) {
        guard let baseURL = URL(string: "https://api.edamam.com/api/recipes/v2") else { return }
        let parameters : [(String,String)] = [("from","to"),("app_id",APIKeys.edamamAppID),("app_key", APIKeys.edamamAPI)]
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
//    func loadmore(completionHandler : ((_ isSucess : Bool) -> Void)?){
//
//            let url = "https://api.edamam.com/api/recipes/v2"
//            session.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler : { response in
//                    switch response.result {
//                    case .success(let data):
//                        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
//                        let decoder = JSONDecoder()
//                        guard let myresult = try? decoder.decode(Welcome.self, from: jsonData) else {return}
//                        self.loadin = myresult.data ?? []
//                        self.tableData.append(contentsOf: myresult.data ?? [])
//                        completionHandler?(true)
//                        print(self.pagecounter)
//                        self.pagecounter += 1
//
//                    //                    print(myresult)
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
//
//        }
//    }
