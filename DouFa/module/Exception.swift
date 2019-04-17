//
//  Exception.swift
//  DouFa
//
//  Created by KyleChen on 2019/4/17.
//  Copyright © 2019 KCG. All rights reserved.
//

import Foundation

enum GetFriendsFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
}
