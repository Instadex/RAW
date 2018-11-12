//
//  WebService.swift
//  RAW
//
//  Created by Bharat malhotra on 13/07/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import Foundation

class WebService {
    
    enum ServiceError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
        case urlInvalid = "ERROR: the URL is invalid"
    }
    
    func getPosts(completion: @escaping(_ userData: [Posts],_ failureMessage: Error?) -> Void){
        var posts = [Posts]()
        guard let endpoint = URL.init(string:ServerConstants.APIEndPoint) else {
            print("Error creating endpoint")
            return completion(posts, ServiceError.urlInvalid)
        }
        let request = URLRequest(url:endpoint)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw ServiceError.NoData
                }
                posts = try JSONDecoder().decode([Posts].self, from: data)
                completion(posts,nil)
            } catch {
                print(error)
                completion(posts,error)
            }
            }.resume()
    }
}
