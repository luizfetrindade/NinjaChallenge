//
//  PostResponse.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 21/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

struct Post: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

