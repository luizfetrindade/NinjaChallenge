//
//  userRequest.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

struct UserRequest: UserRequester {
    
    func getUrl(urlString: String) -> URL {
        var baseUrl: URL {
            guard let url = URL(string: urlString)
                else { fatalError("Invalid UrlPath") }
            return url
        }
        return baseUrl
    }
    
    func fetchUsers(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        
        let newUrl = getUrl(urlString: urlString)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: newUrl) { (data, response, error) in
            
            if let _ = error {
                completionHandler(nil)
            } else {
                if let data = data {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            }
        }
        task.resume()
    }
}
