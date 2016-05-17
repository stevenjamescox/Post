//
//  PostController.swift
//  Post
//
//  Created by Caleb Hicks on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class PostController {
    
    static let sharedController = PostController()
    static let baseURL = NSURL(string: "https://devmtn-post.firebaseio.com")
    static let endpoint = NSURL(string: "https://devmtn-post.firebaseio.com/posts.json")
    
    var posts:[Post] = [] {
        didSet {
            
            for observer in observers {
                observer.postsUpdated(posts)
            }
        }
    }
    
    var observers:[PostControllerObserver] = []
    
    init() {
        fetchPosts()
    }
    
    func addPost(username: String, text: String) {
        
        let post = Post(username: username, text: text)
        post.save {
            self.fetchPosts()
        }
    }
    
    func removePost(post: Post) {
        
        post.delete {
            self.fetchPosts()
        }
    }
    
    // MARK: - Persistence
    
    func fetchPosts(completion: (() -> Void)? = nil) {
        
        guard let endpoint = PostController.endpoint else { fatalError("Post Endpoint url failed") }
        
        NetworkController.performRequestForURL(endpoint, httpMethod: .Get, data: nil) { (data, error) in
            
            guard let data = data,
                let postDictionaries = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: [String: AnyObject]] else {
                    
                    print("unable to serialize json")
                    if let completion = completion {
                        completion()
                    }
                    return
            }
            
            let posts = postDictionaries.flatMap({Post(json: $0.1, identifier: $0.0)})
            let sortedPosts = posts.sort({$0.0.timestamp > $0.1.timestamp})
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.posts = sortedPosts
                
                if let completion = completion {
                    completion()
                }
                
                return
            })
        }
    }
}

protocol PostControllerObserver {
    
    func postsUpdated(posts: [Post])
}