//
//  RawModel.swift
//  RAW
//
//  Created by Bharat malhotra on 13/07/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import Foundation

struct RawModel: Codable {
    
    let userid : Int?
    let id : Int?
    let title : String?
    let body : String?
    
    enum CodingKeys: String, CodingKey {
        case userid = "userid"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userid = try values.decodeIfPresent(Int.self, forKey: .userid)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
    
}
