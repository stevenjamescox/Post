//
//  JSONSavableObject.swift
//  Post
//
//  Created by Caleb Hicks on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

protocol JSONSavableObject {
    
    var endpoint: NSURL? { get }
    var jsonValue: [String: AnyObject] { get }
    
    func save(completion: (() -> ())?)
    
    // TODO add black diamond of updating or deleting
}

extension JSONSavableObject {
    
    func save(completion: (() -> ())? = nil) {
        
        guard let endpoint = self.endpoint else { fatalError("URL optional is nil") }
        
        NetworkController.performRequestForURL(endpoint, httpMethod: .Put, data: self.jsonData) { (data, error) in
            
            if error != nil {
                print("Error: \(error)")
            } else {
                print("Successfully saved data to endpoint.")
            }
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    var jsonData: NSData? {
        
        return try? NSJSONSerialization.dataWithJSONObject(self.jsonValue, options: NSJSONWritingOptions.PrettyPrinted)
    }
    
    var jsonString: NSString {
        
        let string = NSString(data: self.jsonData!, encoding: NSUTF8StringEncoding) ?? ""
        
        return string
    }
    
    // TODO decide if the debugging is worth keeping this in the project
}