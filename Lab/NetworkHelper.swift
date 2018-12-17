//
//  NetworkHelper.swift
//  Lab
//
//  Created by Roberto Evangelista on 16/12/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct NetworkHelper {
    
    func queryItems(dictionary: [String: String]) -> [URLQueryItem] {
        return dictionary.map {
            return URLQueryItem(name: $0, value: $1)
        }
    }
}
