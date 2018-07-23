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
    
    func fetchRawData(sucess:@escaping(_ userData: [PostModel]) -> Void, failure: @escaping(_ failuremessage: String) -> Void){
        guard let endpoint = URL.init(string:ServerConstants.APIEndPoint) else {
            print("Error creating endpoint")
            return failure("URL error")
        }
        let request = URLRequest(url:endpoint)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                let jsonDecoder = JSONDecoder()
                let arrRaw = try jsonDecoder.decode([PostModel].self, from: data)
                sucess(arrRaw)
            } catch let error as JSONError {
                print(error.rawValue)
                failure(error.rawValue)
            } catch let error as NSError {
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
            }.resume()
    }
}
