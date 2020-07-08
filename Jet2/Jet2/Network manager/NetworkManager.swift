//
//  NetworkManager.swift
//  Jet2
//
//  Created by Rahul Varma on 08/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

class NetworkManager
{
    static let shared = NetworkManager()
    var session = URLSession.shared
    
    public init(){}
    
    func apiArticles(apiURL:String, completion : @escaping (Result<[Article], Error>)-> () ){
        
        guard let requestUrl = URL(string: apiURL) else { return }
        let request = URLRequest(url: requestUrl)

        session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data!)
                //self.arrArticles += articles
                print(articles.count)
                
                completion(.success(articles))
                
            }
            catch let jsonErr {
                print("Error serialising json", jsonErr)
                completion(.failure(jsonErr))
            }
            }).resume()
        
    }
    
    func apiUsers(apiURL:String, completion : @escaping (Result<[User], Error>)-> () ){
        
        guard let requestUrl = URL(string: apiURL) else { return }
        let request = URLRequest(url: requestUrl)

        session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data!)
                //self.arrArticles += articles
                print(users.count)
                
                completion(.success(users))
                
            }
            catch let jsonErr {
                print("Error serialising json", jsonErr)
                completion(.failure(jsonErr))
            }
            }).resume()
        
    }
}