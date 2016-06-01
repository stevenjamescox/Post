//
//  Post.swift
//  Post
//
//  Created by Steve Cox on 6/1/16.
//  Copyright © 2016 SteveCox. All rights reserved.
//

import Foundation

struct Post {
    
    private let keyUsername = "username"
    private let keyText = "text"
    private let keyTimestamp = "timestamp"
    private let keyIdentifier = "identifier"
    
    let username: String
    let text: String
    let timestamp: NSTimeInterval
    let identifier: NSUUID
    
    init(username: String, text: String, identifier: NSUUID = NSUUID()) {
    self.username = username
    self.text = text
    self.timestamp = NSDate().timeIntervalSince1970
    self.identifier = identifier
        
    }

    init?(json: [String: AnyObject], identifier: String) {
    guard let username = json[keyUsername] as? String,
        let text = json[keyText] as? String,
        let timestamp = json[keyTimestamp] as? Double,
        let identifier = NSUUID(UUIDString: identifier)
        else { return nil }
        
        self.username = username
        self.text = text
        self.timestamp = NSTimeInterval(floatLiteral: timestamp)
        self.identifier = identifier
        
    }

}