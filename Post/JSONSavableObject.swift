//
//  JSONSavableObject.swift
//  Post
//
//  Created by Caleb Hicks on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

protocol JSONSavableObject {
    
    var endpoint: NSURL { get }
    var jsonValue: [String: AnyObject] { get }
    
    func save(completion: (() -> ())?)
    func update(completion: (() -> ())?)
    func delete(completion: (() -> ())?)
}

extension JSONSavableObject {
    
    func save(completion: (() -> ())? = nil) {
        
        NetworkController.performRequestForURL(self.endpoint, httpMethod: .Put, data: self.jsonData) { (data, error) in
            
            if error != nil {
                // perform marvellous error handling here
            } else {
                print("Successfully saved data to endpoint.")
            }
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    func update(completion: (() -> ())? = nil) {
        
        NetworkController.performRequestForURL(self.endpoint, httpMethod: .Patch, data: self.jsonData) { (data, error) in
            
            if error != nil {
                // perform marvellous error handling here
            } else {
                print("Successfully patched data to endpoint.")
            }
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    func delete(completion: (() -> ())? = nil) {
        
        NetworkController.performRequestForURL(self.endpoint, httpMethod: .Delete, data: self.jsonData) { (data, error) in
            
            if error != nil {
                // perform marvellous error handling here
            } else {
                print("Successfully deleted data from endpoint.")
            }
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    var jsonData: NSData? {
        
        return try! NSJSONSerialization.dataWithJSONObject(self.jsonValue, options: NSJSONWritingOptions.PrettyPrinted)
    }
    
    var jsonString: NSString {
        
        let string = NSString(data: self.jsonData!, encoding: NSUTF8StringEncoding) ?? ""
        
        return string
    }
}