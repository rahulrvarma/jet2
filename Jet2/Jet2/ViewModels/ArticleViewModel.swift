//
//  ArticleViewModel.swift
//  Jet2
//
//  Created by Rahul Varma on 09/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

protocol ArticleDelegate {
    func dataReceivedForArticle(articles : [Article])
}
class ArticleViewModel {
    
    var articleDelegate : ArticleDelegate?

    func loadArticles(forPage : Int) {
    //        let semphore = DispatchSemaphore(value: 0)
            NetworkManager.shared.apiArticles(page: forPage) { (result) in
    //            semphore.signal()
                switch result {
                case .success(let article):

                    self.articleDelegate?.dataReceivedForArticle(articles: article)

                case .failure(let err):
                    print("Failed to fetch articles : ", err)
                }
            }
    //        _ = semphore.wait(timeout: .distantFuture)
        }
        
        
    
    func loadUsers(forPage : Int) {
            NetworkManager.shared.apiUsers(page: forPage) { (result) in
                
                switch result {
                case .success(let user):
//                    self.arrUsers += user
//                    self.arrUsers.forEach { (userobj) in
                        print(user.count)
//                    }
                case .failure(let err):
                    print("Failed to fetch users : ", err)
                }
            }
        }
}
