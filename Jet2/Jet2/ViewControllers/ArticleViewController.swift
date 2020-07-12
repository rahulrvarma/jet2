//
//  ViewController.swift
//  Jet2
//
//  Created by Rahul Varma on 07/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
   
    var page = 1
    var loadMoreData : Bool = true
    var arrArticles = [Article]()
    var articleVM : ArticleViewModel!
    
    @IBOutlet weak var tableArticle: UITableView!
    
    fileprivate func tableViewSetup() {
        tableArticle.dataSource = self
        tableArticle.delegate = self
        tableArticle.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableArticle.rowHeight = UITableView.automaticDimension
        tableArticle.estimatedRowHeight = 600
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Articles"
        self.articleVM = ArticleViewModel(delegate: self)
        
        tableViewSetup()
        
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.loadArticles()
        })
    }

    func loadArticles() {
        self.articleVM.loadArticles(forPage : page)
    }
}

extension ArticleViewController : ArticleDelegate{
    
    func dataReceivedForArticle(articles: [Article]?) {
        if let nextArticle = articles {
            
            if nextArticle.count > 0 {
                page += 1
                self.arrArticles += nextArticle
            }
            else
            {
                loadMoreData = false
            }
            print(self.arrArticles.count)
            DispatchQueue.main.async {
                self.tableArticle.reloadData()
            }
        }
        
    }
}
    


extension ArticleViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell

        cell.configureCell(article: self.arrArticles[indexPath.row])
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if loadMoreData && indexPath.row == self.arrArticles.count-2 {
            loadArticles()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        self.navigationController?.pushViewController(UsersViewController(), animated: true)

        let profileVC = ProfileViewController(user: self.arrArticles[indexPath.row].user.first!)
        self.navigationController?.pushViewController(profileVC, animated: true)

    }
    
}
