//
//  ViewController.swift
//  NinjaChallenge
//
//  Created by Luiz Felipe Trindade on 21/05/19.
//  Copyright © 2019 NinjaChallengeLuiz. All rights reserved.
//

import UIKit

class PostController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postsTableView: UITableView!
    
    let postProvider = PostProvider()
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"
        
        postProvider.providePost { [weak self] (posts) in
            guard let strongSelf = self, let posts = posts else { return }
            strongSelf.posts = posts
            
            DispatchQueue.main.async {
                strongSelf.postsTableView.reloadData()
            }
        }
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        let nibName = UINib(nibName: "PostTableViewCell", bundle: nil)
        postsTableView.register(nibName, forCellReuseIdentifier: "postTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PostDetailViewController, segue.identifier == "postDetails" {
            guard let post = sender as? Post else { return }
            vc.post = post
        }
    }
}

// MARK: - TableView Methods
extension PostController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as? PostTableViewCell {
            let post = posts[indexPath.row]
            
            cell.commonInit(title: post.title!)
            cell.postTitle.numberOfLines = 0
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "postDetails", sender: post)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


