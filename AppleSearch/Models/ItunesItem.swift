//
//  itunesItem.swift
//  AppleSearch
//
//  Created by Ben Huggins on 2/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation


struct TopLevelJSON: Codable {
    let results: [ItunesItem]
    
}

struct ItunesItem: Codable {
    
    let artistName : String
    let albumName: String?
    let songName: String
    let albumImageAsString: String
  
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case songName = "trackName"
        case albumImageAsString = "artworkUrl100"

    }

}
