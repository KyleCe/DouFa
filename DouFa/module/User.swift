//
//  User.swift
//  DouFa
//
//  Created by KyleChen on 2019/4/16.
//  Copyright © 2019 KCG. All rights reserved.
//

import Foundation


class Post : Codable{
   var userId: Int
   var id: Int
   var title: String
   var body: String
    
    init( userId: Int, id: Int,title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title=title
        self.body = body
    }
}

class Friend :Codable{
    var firstname:String
    var id:Int
    var lastname:String
    var phonenumber:String
}

class LoginResult: Codable {
    let accessToken: String
    let doubanUserName: String
    let doubanUserId: String
    let expiresIn: Int
    let refreshToken: String
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case doubanUserName = "douban_user_name"
        case doubanUserId = "douban_user_id"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
