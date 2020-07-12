//
//  UsersViewModel.swift
//  Jet2
//
//  Created by Rahul Varma on 11/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

protocol UsersDelegate {
    func dataReceivedForUsers(users : [User]?)
}
class UsersViewModel : UsersInterface {
    
    var usersDelegate : UsersDelegate
    
    init(delegate : UsersDelegate) {
        self.usersDelegate = delegate
    }
    
    func loadUsers(forPage : Int) {
        NetworkManager.shared.apiUsers(page: forPage) { (result) in
            
            switch result {
            case .success(let users):
                
                self.usersDelegate.dataReceivedForUsers(users: users)
                
            case .failure(let err):
                self.usersDelegate.dataReceivedForUsers(users: nil)
                
                print("Failed to fetch articles : ", err.localizedDescription)
            }
        }
    }
}
