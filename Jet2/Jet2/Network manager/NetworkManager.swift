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
    
    func apiArticles(apiURL:String) {
        
        guard let requestUrl = URL(string: apiURL) else { return }
        let request = URLRequest(url: requestUrl)

        session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            
            guard let data = data else { return }
            
            self.parseArticles(data)
            
            }).resume()
        
    }
    
    func apiUsers(apiURL:String) {
        
        guard let requestUrl = URL(string: apiURL) else { return }
        let request = URLRequest(url: requestUrl)

        session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            
            guard let data = data else { return }
            
            self.parseUsers(data)
            
            }).resume()
        
    }
}

extension NetworkManager {
    
    fileprivate func parseArticles(_ data: Data) {
        do {
            let articles = try JSONDecoder().decode([Article].self, from: data)
            print(articles.count)
        }
        catch let jsonErr {
            print("Error serialising json", jsonErr)
        }
    }
    
    fileprivate func parseUsers(_ data: Data) {
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            print(users.count)
        }
        catch let jsonErr {
            print("Error serialising json", jsonErr)
        }
    }
}








