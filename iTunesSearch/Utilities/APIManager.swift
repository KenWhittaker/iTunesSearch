//
//  APIManager.swift
//  iTunesSearch
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

import Foundation
import SwiftyJSON

public class APIManager {
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: JSON) -> ()) {
        
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    
                    completion(true, JSON(data))
                    
                } else {
                    
                    completion(false, JSON(data))
                }
            }
            
        }.resume()
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: JSON) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func clientURLRequest(path: String, params: String) -> NSMutableURLRequest {
        
        let urlString = Constants.urls.base + path + params
        let url = URL(string: urlString)!
        let request = NSMutableURLRequest(url: url)
        
        return request
    }
    
    func search(term: String, entity: String, completion: @escaping (_ success: Bool, _ message: JSON?) -> ()) {
        
        let encodedTerm = term.replacingOccurrences(of: " ", with: "+").lowercased()
        
        get(request: clientURLRequest(path: Constants.routes.path, params: "?" + "term=" + encodedTerm + "&entity=" + entity)) { (success, object) -> () in
            
            DispatchQueue.main.async {
                
                if success {
                    
                    completion(true, object[Constants.keys.results])
                    
                } else {
                    
                    completion(false, object[Constants.keys.errorMessage])
                }
            }
        }
    }
}
