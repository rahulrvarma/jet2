//
//  UsersViewController.swift
//  Jet2
//
//  Created by Rahul Varma on 11/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var page = 1
    var arrUsers = [User]()
    var usersVM = UsersViewModel()
    var loadMoreData : Bool = true
    
    @IBOutlet weak var tableUsers: UITableView!
    
    init() {
        super.init(nibName: "UsersViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func tableViewSetup() {
        tableUsers.dataSource = self
        tableUsers.delegate = self
        tableUsers.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Users"
        self.usersVM.usersDelegate = self
        
        tableViewSetup()
        
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.loadUsers()
        })
    }
    
    func loadUsers() {
        self.usersVM.loadUsers(forPage : page)
    }
}

extension UsersViewController : UsersDelegate{
    
    func dataReceivedForUsers(users: [User]?) {
        if let nextUsers = users {
            
            if nextUsers.count > 0 {
                page += 1
                self.arrUsers += nextUsers
            }
            else
            {
                loadMoreData = false
            }
            print(self.arrUsers.count)
            DispatchQueue.main.async {
                self.tableUsers.reloadData()
            }
        }
    }
}

extension UsersViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        
        cell.configureCell(user: self.arrUsers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
           if loadMoreData && indexPath.row == self.arrUsers.count-2 {
               loadUsers()
           }
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let profileVC = ProfileViewController(user: self.arrUsers[indexPath.row])
            self.navigationController?.pushViewController(profileVC, animated: true)

        }
}
