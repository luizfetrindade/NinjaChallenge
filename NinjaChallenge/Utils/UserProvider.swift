//
//  UserProvider.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

// An object that can Request users
protocol UserRequester {
    func fetchUsers(urlString: String, completionHandler: @escaping (Data?) -> Void)
}

struct UserProvider {
    
    var userData: UserRequester = UserRequest()
    var parser = DataParser()
    var urlBase = "https://jsonplaceholder.typicode.com/users?id="
    
    func provideUser(url: String, completionHandler: @escaping ([User]?) -> Void) {
        userData.fetchUsers( urlString: urlBase+url, completionHandler: { (data) in
            let users = self.parser.userParse(data: data!)
            completionHandler(users)
        })
    }
}

