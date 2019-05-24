//
//  PostRequest.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

struct PostRequest: PostRequester {

    let baseUrlPath = "https://jsonplaceholder.typicode.com/posts/"
    var baseUrl: URL {
        guard let url = URL(string: baseUrlPath)
            else { fatalError("Invalid UrlPath") }
        return url
    }
    
    func fetchPosts(completionHandler: @escaping (Data?) -> Void) {
        let session = URLSession.shared

        let task = session.dataTask(with: baseUrl) { (data, response, error) in
            
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
