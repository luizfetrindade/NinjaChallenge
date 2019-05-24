//
//  UserResponse.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Adress?
    var phone: String?
    var website: String?
    var company: Company?
}

struct Adress: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

struct Geo: Codable {
    var lat: String?
    var lng: String?
}

struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}
