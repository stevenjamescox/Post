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
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

        PostController.sharedController.observers.append(self)
        // TODO decide between observers or just one delegate
        // TODO decide on shared instance vs single instance
        // TODO consider doing the shared instance with multiple observers in Timeline/Chat
    }

    @IBAction func newPostTapped(sender: AnyObject) {
    
        presentNewPostAlert()
    }
    
    @IBAction func refreshControlPulled(sender: UIRefreshControl) {
        
        PostController.sharedController.fetchPosts { 
            
            sender.endRefreshing()
        }
    }
    
    func presentNewPostAlert() {
        let alertController = UIAlertController(title: "New Post", message: nil, preferredStyle: .Alert)
        
        var usernameTextField: UITextField?
        var messageTextField: UITextField?
        
        alertController.addTextFieldWithConfigurationHandler { (usernameField) in
            usernameField.placeholder = "Display name"
            usernameTextField = usernameField
        }
        
        alertController.addTextFieldWithConfigurationHandler { (messageField) in
            
            messageField.placeholder = "What's up?"
            messageTextField = messageField
        }
        
        let postAction = UIAlertAction(title: "Post", style: .Default) { (action) in
            
            guard let username = usernameTextField?.text,
                let text = messageTextField?.text else {
                
                    self.presentErrorAlert()
                    return
            }
            
            PostController.sharedController.addPost(username, text: text)
        }
        alertController.addAction(postAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentErrorAlert() {
        
        let alertController = UIAlertController(title: "Uh oh!", message: "You may be missing information, or have network connectivity issues. Please try again.", preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
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
