//
//  ViewController.swift
//  Jet2
//
//  Created by Rahul Varma on 07/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var page = 0
    var arrArticles = [Article]()
    var arrUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    fileprivate func loadArticles() {
        NetworkManager.shared.apiArticles(apiURL: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(page)&limit=10") { (result) in
            
            switch result {
            case .success(let artile):
                self.arrArticles += artile
                self.arrArticles.forEach { (artileobj) in
                    print(artileobj.content)
                }
            case .failure(let err):
                print("Failed to fetch articles : ", err)
            }
        }
    }
    
    fileprivate func loadUsers() {
        NetworkManager.shared.apiUsers(apiURL: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/users?page=\(page)&limit=10") { (result) in
            
            switch result {
            case .success(let user):
                self.arrUsers += user
                self.arrUsers.forEach { (userobj) in
                    print(userobj.name)
                }
            case .failure(let err):
                print("Failed to fetch users : ", err)
            }
        }
    }
    
    @IBAction func click(_ sender: Any) {
        
        page += 1
        loadArticles()
        loadUsers()
    }
    
}

