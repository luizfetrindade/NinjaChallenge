//
//  PostProviders.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

protocol PostRequester {
     func fetchPosts(completionHandler: @escaping (Data?) -> Void)
}

struct PostProvider {
    
    var postData: PostRequester = PostRequest()
    var parser = DataParser()
    
    func providePost(completionHandler: @escaping ([Post]?) -> Void) {
        postData.fetchPosts { (data) in
            let posts = self.parser.postParse(data: data!)
            completionHandler(posts)
        }
    }
}
