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
        
        NetworkController.performRequestForURL(requestURL, httpMethod: .Get, urlParameters: nil) { (data, error) in
            
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            guard let data = data,
                
                let postDictionaries = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: [String: AnyObject]]
                else {
                    print("Cannot serialize JSON file. \nResponse: \(responseDataString)")
                    if let completion = completion {
                        completion(newPosts: [])
                    }
                    return }
            let posts = postDictionaries.flatMap({Post(json: $0.1, identifier: $0.0)})
            
            let sortedPosts = posts.sort({$0.0.timestamp > $0.1.timestamp})
            
            dispatch_async(dispatch_get_main_queue(),{
                self.posts = sortedPosts
                
                if let completion = completion {
                    
                    completion(newPosts: sortedPosts)
                }
                return
            })
            
        }
    }
}

protocol PostControllerDelegate: class {
    
    func postsUpdated(posts: [Post])
}



