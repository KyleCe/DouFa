//
//  AuthHelper.swift
//  DouFa
//
//  Created by KyleChen on 2019/4/16.
//  Copyright © 2019 KCG. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class AuthHelper:NSObject{
    
    internal static let AUTH_FOR_TOKEN  = "https://www.douban.com/service/auth2/token"
    
    private(set) public var username : String? = nil
    private(set) public var userUrl : String? = nil
    //    private(set) public var userIcon = NSImage.init(named: NSImageNameUser)
    private(set) public var isPro: Bool = false
    private(set) public var promotion_chls : Array<Dictionary<String, AnyObject>> = []
    private(set) public var recent_chls : Array<Dictionary<String, AnyObject>> = []
    private(set) public var userInfo : Dictionary<String, AnyObject> = [:]
    
    static let instance = AuthHelper()
    
    private override init() {}
    
    func login(account:String, _password:String) -> Observable<LoginResult> {
        return getFriends(username: account, password: _password)
    }
    
    func getFriends(username:String, password:String) -> Observable<LoginResult> {
        return Observable.create { observer -> Disposable in
            AF.request(AuthHelper.AUTH_FOR_TOKEN, method: .post,
                       parameters: [
                        "client_id":"02646d3fb69a52ff072d47bf23cef8fd",
                        "client_secret":"cde5d61429abcd7c",
                        "grant_type":"password",
                        "username":username,
                        "password":password
                ], headers: ["Content-Type":"application/x-www-form-urlencoded"])
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            observer.onError(response.error ?? GetFriendsFailureReason.notFound)
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(LoginResult.self, from: data)
                            observer.onNext(result)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = GetFriendsFailureReason(rawValue: statusCode)
                        {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
}
