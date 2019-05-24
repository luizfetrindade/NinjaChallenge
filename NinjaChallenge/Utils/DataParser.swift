//
//  DataParser.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()

struct DataParser {
    
    func postParse(data: Data) -> [Post]? {
        let postResponse = try? decoder.decode([Post].self, from: data)
        return postResponse
    }
    
    func userParse(data: Data) -> [User]? {
        let userResponse = try? decoder.decode([User].self, from: data)
        return userResponse
    }
}
