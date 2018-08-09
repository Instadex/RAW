//
//  WebService.swift
//  RAW
//
//  Created by Bharat malhotra on 13/07/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import Foundation

class WebService {
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func getPostsData(output:@escaping(_ userData: [PostModel],_ failureMessage: String) -> Void){
        var postData = [PostModel]()
        guard let endpoint = URL.init(string:ServerConstants.APIEndPoint) else {
            print("Error creating endpoint")
            return output(postData,"URL error")
        }
        let request = URLRequest(url:endpoint)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                let jsonDecoder = JSONDecoder()
                postData = try jsonDecoder.decode([PostModel].self, from: data)
                output(postData,"")
            } catch let error as JSONError {
                print(error.rawValue)
                output(postData,error.rawValue)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            }.resume()
    }
}
