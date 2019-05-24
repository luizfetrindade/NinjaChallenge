//
//  NinjaChallengeTests.swift
//  NinjaChallengeTests
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import XCTest

@testable import NinjaChallenge

class NinjaChallengeTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testUserParse() {
        let user = User(id: 1, name: "", username: "", email: "", address: nil, phone: "", website: "", company: nil)
        
        let parser = DataParser()
        let parsableData = getJsonMockAsData(nameFile: "oneUserJson")
        var users = [User]()
        
        users.append(user)
        
        let parseResult = parser.userParse(data: parsableData)
        XCTAssertTrue((parseResult![0].id == users[0].id))
    }
    
    func testPostParse() {
        let post = Post(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        let parser = DataParser()
        let parsableData = getJsonMockAsData(nameFile: "onePostJson")
        var posts = [Post]()
        
        posts.append(post)
        
        let parseResult = parser.postParse(data: parsableData)
        XCTAssertEqual(parseResult![0].title, posts[0].title)
    }
    
    func testUserDataParserNil() {
        let parser = DataParser()
        let data = Data()
        let parsedPosts = parser.userParse(data: data)
        XCTAssertNil(parsedPosts)
    }
    
    func testPostDataParserNil() {
        let parser = DataParser()
        let data = Data()
        let parsedPosts = parser.postParse(data: data)
        XCTAssertNil(parsedPosts)
    }
    
    func testGetUrl() {
        let urlString = "https://google.com"
        let requester = UserRequest()
        let url = URL(string: "https://google.com")
        let urlToBeTested = requester.getUrl(urlString: urlString)
        
        XCTAssertEqual(urlToBeTested, url)
    }
    
    func testFetchUsers() {
        let requester = UserRequest()
        let url = "https://jsonplaceholder.typicode.com/users?id=1"
        
        let expectation = self.expectation(description: "Retrive Data")
        
        requester.fetchUsers(urlString: url) { data in
            XCTAssertTrue((data != nil))
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Not working \(error)")
            }
        }
    }
    
    func testProvidUserRequest() {
        let provider = UserProvider()
        let urlBase = "https://jsonplaceholder.typicode.com/users?id=1"
        
        let expectation = self.expectation(description: "Retrive Data")
        
        provider.provideUser(url: urlBase) { (user) in
            XCTAssertTrue((user != nil))
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Not working \(error)")
            }
        }
    }
    
    func testFetchUserMock() {
        let userMock = UserRequesterMock()
        let url = "https://jsonplaceholder.typicode.com/users?id=1"

        let parser = DataParser()
            
        userMock.fetchUsers(urlString: url) { (mockedData) in
            guard let mockedData = mockedData else{ XCTFail("Invalid mocked data"); return }
            let arrayUsers = parser.userParse(data: mockedData)
            XCTAssertNotNil(arrayUsers)
        }
    }
    
    func testFetchPostMock() {
        let postMock = PostRequesterMock()
        
        let parser = DataParser()
        
        postMock.fetchPosts { (mockedData) in
            guard let mockedData = mockedData else { XCTFail("Invalid mocked data"); return }
            let posts = parser.postParse(data: mockedData)
            XCTAssertNotNil(posts)
        }
    }
}


func getJsonMockAsData(nameFile: String) -> Data {
    let file = Bundle.main.path(forResource: nameFile, ofType: "json")!
    let data = (try? Data(contentsOf: URL(fileURLWithPath: file), options: .alwaysMapped))!
    return data
}

struct UserRequesterMock: UserRequester {
    func fetchUsers(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(getJsonMockAsData(nameFile: "userJson"))
    }
}

struct PostRequesterMock: PostRequester {
    func fetchPosts(completionHandler: @escaping (Data?) -> Void) {
        completionHandler(getJsonMockAsData(nameFile: "postsJson"))
    }
}

