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
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        postController.delegate = self
        
    }
    
    @IBAction func refreshControlPulled(sender: UIRefreshControl){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        postController.fetchPosts( { (newPosts) in
            sender.endRefreshing()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
        })
        
        
        
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

extension PostListTableViewController: PostControllerDelegate {
    func postsUpdated(posts: [Post]) {
        tableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

}





