//
//  Post.swift
//  Post
//
//  Created by Caleb Hicks on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: JSONSavableObject {
    
    private let UsernameKey = "username"
    private let TextKey = "text"
    private let TimestampKey = "timestamp"
    private let UUIDKey = "uuid"
    
    let username: String
    let text: String
    let timestamp: NSTimeInterval
    let identifier: NSUUID
    
    var endpoint: NSURL {
        return (PostController.baseURL?.URLByAppendingPathComponent("posts").URLByAppendingPathComponent(self.identifier.UUIDString).URLByAppendingPathExtension("json"))!
    }
    
    var jsonValue: [String: AnyObject] {
        
        let json: [String: AnyObject] = [
                UsernameKey: self.username,
                TextKey: self.text,
                TimestampKey: self.timestamp,
            ]
        
        return json
    }
    
    init(username: String, text: String, identifier: NSUUID = NSUUID()) {
        
        self.username = username
        self.text = text
        self.timestamp = NSDate().timeIntervalSince1970
        self.identifier = identifier
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let username = json[UsernameKey] as? String,
            let text = json[TextKey] as? String,
            let timestamp = json[TimestampKey] as? Double else { return nil }
        
        self.username = username
        self.text = text
        self.timestamp = NSTimeInterval(floatLiteral: timestamp)
        self.identifier = NSUUID(UUIDString: identifier)!
        
        // TODO Fix
    }
    
}