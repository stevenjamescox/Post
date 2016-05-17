//
//  NetworkController.swift
//  Post
//
//  Created by Caleb Hicks on 5/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequestForURL(url: NSURL, httpMethod: HTTPMethod, data: NSData?, headers: [String: String]? = nil, completion:((data: NSData?, error: NSError?) -> Void)?) {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = httpMethod.rawValue
        request.HTTPBody = data
        
        if let headers = headers {
            for (headerKey, value) in headers {
                
                request.addValue(value, forHTTPHeaderField: headerKey)
            }
        }
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let completion = completion {
                completion(data: data, error: error)
            }
        }
        
        dataTask.resume()
    }
    
}