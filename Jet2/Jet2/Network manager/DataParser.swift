//
//  DataParser.swift
//  Jet2
//
//  Created by Rahul Varma on 08/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation

struct Article : Decodable {
    let id : String
    let createdAt : String
    let content : String
    let comments : Int
    let likes : Int
    let media : [Media]
    let user : [User]
}

struct Media : Decodable {
    let id : String
    let blogId : String
    let createdAt : String
    let image : String
    let title : String
    let url : String
}

struct User : Decodable {
    let id : String
    let blogId : String?    //used only in article
    let createdAt : String
    let name : String
    let avatar : String
    let lastname : String
    let city : String
    let designation : String
    let about : String
}
