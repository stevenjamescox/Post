//
//  PostListTableTableViewController.swift
//  Post
//
//  Created by Steve Cox on 6/1/16.
//  Copyright © 2016 SteveCox. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    let postController = PostController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.posts.count

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)
        let post = postController.posts[indexPath.row]
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(indexPath.row) - \(post.username) - \(NSDate (timeIntervalSince1970: post.timestamp))"
    
        return cell
    }
}
