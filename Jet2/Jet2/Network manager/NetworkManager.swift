//
//  NetworkManager.swift
//  Jet2
//
//  Created by Rahul Varma on 08/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

struct APINames {
    static let APIArticle = "Article"
    static let APIUser = "User"
}

class NetworkManager
{
    static let shared = NetworkManager()
    var session = URLSession.shared
    
    public init(){}
    
    func apiArticles(page:Int, completion : @escaping (Result<[Article], Error>)-> () ){
        
        if ConnectionCheck.shared.isConneted
        {
            
            guard let requestUrl = URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(page)&limit=10") else { return }
            let request = URLRequest(url: requestUrl)
            
            session.dataTask(with: request, completionHandler: {
                (data, response, err) in
                
                if let err = err {
                    completion(.failure(err))
                }
                else{
                    
                    do {
                        
                        let result = try JSONDecoder().decode([Article].self, from: data!)
                        if result.count == 0
                        {
                            completion(.success(result))
                        }
                        else
                        {
                            
                            if page == 1
                            {
                                PersistentManager.shared.deleteData(apiName: APINames.APIArticle)
                            }
                            
                            PersistentManager.shared.insertData(apiName: APINames.APIArticle, apiData: data!, page: page)
                            
                            let retreivedData = PersistentManager.shared.retrieveData(apiName: APINames.APIArticle, page: page)
                            let articles = try JSONDecoder().decode([Article].self, from: retreivedData!)
                            
                            print(articles.count)
                            
                            completion(.success(articles))
                        }
                    }
                    catch let jsonErr {
                        print("Error serialising json", jsonErr)
                        completion(.failure(jsonErr))
                    }

                }
            }).resume()
        }
        else
        {
            print("LOAD OFFLINE DATA")
            
            do{
                
                let retreivedData = PersistentManager.shared.retrieveData(apiName: APINames.APIArticle, page: page)
                let articles = try JSONDecoder().decode([Article].self, from: retreivedData!)
                
                print(articles.count)
                
                completion(.success(articles))
                
            }
            catch let jsonErr {
                print("Error serialising json", jsonErr)
                completion(.failure(jsonErr))
            }
        }
    }
    
    
    
    func apiUsers(page:Int, completion : @escaping (Result<[User], Error>)-> () ){
        
        if ConnectionCheck.shared.isConneted
        {
            guard let requestUrl = URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/users?page=\(page)&limit=10") else { return }
            let request = URLRequest(url: requestUrl)

            session.dataTask(with: request, completionHandler: {
                (data, response, err) in
                
                if let err = err {
                    completion(.failure(err))
                }
                else{
                    
                    do {
                        
                        let result = try JSONDecoder().decode([User].self, from: data!)
                        if result.count == 0
                        {
                            completion(.success(result))
                        }
                        else
                        {
                            
                            if page == 1
                            {
                                PersistentManager.shared.deleteData(apiName: APINames.APIUser)
                            }
                            
                            PersistentManager.shared.insertData(apiName: APINames.APIUser, apiData: data!, page: page)
                            
                            let retreivedData = PersistentManager.shared.retrieveData(apiName: APINames.APIUser, page: page)
                            let users = try JSONDecoder().decode([User].self, from: retreivedData!)
                            
                            print(users.count)
                            
                            completion(.success(users))
                        }
                    }
                    catch let jsonErr {
                        print("Error serialising json", jsonErr)
                        completion(.failure(jsonErr))
                    }

                }
            }).resume()

        }
        else
        {
            print("LOAD OFFLINE DATA")
            
            do{
                
                let retreivedData = PersistentManager.shared.retrieveData(apiName: APINames.APIUser, page: page)
                let users = try JSONDecoder().decode([User].self, from: retreivedData!)
                
                print(users.count)
                
                completion(.success(users))
                
            }
            catch let jsonErr {
                print("Error serialising json", jsonErr)
                completion(.failure(jsonErr))
            }
        }
                
    }
}
