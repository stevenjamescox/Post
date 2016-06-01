//
//  PostController.swift
//  Post
//
//  Created by Steve Cox on 6/1/16.
//  Copyright © 2016 SteveCox. All rights reserved.
//

import Foundation

class PostController {
    
    static let endpoint = NSURL(string: "https://devmtn-post.firebaseio.com/posts.json")
    
    var posts: [Post] = []

     func fetchPosts(completion: ((newPosts: [Post]) -> Void)? = nil){
        
        guard let requestURL = PostController.endpoint else {fatalError("URL optional is nil")}
        
        NetworkController.performRequestForURL(requestURL, httpMethod: .Get, urlParameters: nil) { (data, error)

        }
    }
}