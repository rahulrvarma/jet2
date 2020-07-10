//
//  ViewController.swift
//  Jet2
//
//  Created by Rahul Varma on 07/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
   
    var page = 0
    var arrArticles = [Article]()
    var arrUsers = [User]()
    var articleVM = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.articleVM.articleDelegate = self
    }
    
    
    @IBAction func click(_ sender: Any) {
        page += 1
        
        self.articleVM.loadArticles(forPage : page)
    }
    
}

extension ArticleViewController : ArticleDelegate{
 
    func dataReceivedForArticle(articles: [Article]) {
        self.arrArticles += articles
    }
    
}
