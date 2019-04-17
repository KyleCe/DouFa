//
//  ViewController.swift
//  DouFa
//
//  Created by KyleChen on 2019/4/15.
//  Copyright © 2019 KCG. All rights reserved.
//

import Cocoa
import Alamofire
import RxSwift

class ViewController: NSViewController {
    @IBOutlet weak var account: NSTextField!
    @IBOutlet weak var password: NSTextField!
    @IBOutlet weak var loginBtn: NSButton!
    
    static let KEY_TOKEN  = "key_token"
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        // Getting
        if let stringOne = defaults.string(forKey: ViewController.KEY_TOKEN) {
            password.stringValue = stringOne // Some String Value
            print(stringOne)
        }
    }
    
    @IBAction func loginClick(_ sender: Any) {
        bag.insert(
            AuthHelper.instance.login(account: account.stringValue, _password: password.stringValue)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: {[weak self] result in
                        
                        // Store value
                        self!.password!.stringValue = result.accessToken
                        self!.storeData(_result: result)
                    },
                    onError: { [weak self] error in
                        // Present error
                    }
        ))
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func storeData(_result : LoginResult){
        // Setting
        let defaults = UserDefaults.standard
        defaults.set(_result.accessToken, forKey: ViewController.KEY_TOKEN)
        
        // Getting
        //        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
        //            print(stringOne) // Some String Value
        //        }
    }
}

