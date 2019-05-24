//
//  PostDetailViewController.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 22/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class PostDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var postTitle: UILabel!

    @IBOutlet weak var authorsName: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var webViewUser: WKWebView!
    @IBOutlet weak var backViewShadow: UIView!
    
    
    
    let userProvider = UserProvider()
    var users: [User] = []
    var post = Post()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Description"
        
        postTitle.text = post.title
        postBody.text = post.body
        setShadow()
        
        webViewUser.uiDelegate = self
        webViewUser.allowsBackForwardNavigationGestures = true
        
        userProvider.provideUser( url: "\(post.userId!)", completionHandler: { [weak self] (users) in
            guard let self = self, let users  = users else { return }
            self.users = users
            
            DispatchQueue.main.async {
    
                self.authorsName.text = users[0].name
                guard let web = users[0].website else { return }
                guard let url = URL(string: "http://\(String(web))") else { return }
                self.webViewUser.load(URLRequest(url: url))
            }
        })
    }
    
    func setShadow() {
        backViewShadow.layer.masksToBounds = false
        backViewShadow.layer.shadowOffset = CGSize(width: 5, height: 5)
        backViewShadow.layer.shadowRadius = 10
        backViewShadow.layer.shadowOpacity = 0.2
    }
}
