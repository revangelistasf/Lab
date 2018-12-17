//
//  Movie.swift
//  Lab
//
//  Created by Roberto Evangelista on 17/12/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let duration: Int?
    let poster: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case duration = "runtime"
        case poster = "backdrop_path"
        case releaseDate = "release_date"
    }
}
