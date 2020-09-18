//
//  SearchModel.swift
//  iTunes
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation

struct Result: Decodable {
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var primaryGenreName: String?
    var previewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case collectionName
        case trackName
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100
        case primaryGenreName
        case previewUrl
    }
}

struct Results: Decodable {
    var resultCount: Int
    var results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
}
