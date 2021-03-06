//
//  ArticleViewModel.swift
//  Jet2
//
//  Created by Rahul Varma on 09/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

protocol ArticleDelegate {
    func dataReceivedForArticle(articles : [Article]?)
}

class ArticleViewModel : ArticleInterface {
    
    let articleDelegate : ArticleDelegate
    
    init(delegate : ArticleDelegate) {
        self.articleDelegate = delegate
    }
    
    func loadArticles(forPage : Int) {
        
        NetworkManager.shared.apiArticles(page: forPage) { (result) in
            switch result {
            case .success(let article):
                
                self.articleDelegate.dataReceivedForArticle(articles: article)
                
            case .failure(let err):
                self.articleDelegate.dataReceivedForArticle(articles: nil)
                
                print("Failed to fetch articles : ", err.localizedDescription)
            }
        }
    }
}
