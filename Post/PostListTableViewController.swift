//
//  PostListTableViewController.swift
//  Post
//
//  Created by Caleb Hicks on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        PostController.sharedController.observers.append(self)
    }

    @IBAction func newPostTapped(sender: AnyObject) {
    
        let alertController = UIAlertController(title: "New Post", message: nil, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = "What's up?"
        }
        
        let postAction = UIAlertAction(title: "Post", style: .Default) { (action) in
            
            if let text = alertController.textFields?.first?.text {
                PostController.sharedController.addPost("Caleb Hicks", text: text)
            }
        }
        alertController.addAction(postAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func refreshControlPulled(sender: UIRefreshControl) {
        
        PostController.sharedController.fetchPosts { 
            
            sender.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PostController.sharedController.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)

        let post = PostController.sharedController.posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = post.username

        return cell
    }

}

extension PostListTableViewController: PostControllerObserver {
    
    func postsUpdated(posts: [Post]) {
        
        tableView.reloadData()
    }
}
