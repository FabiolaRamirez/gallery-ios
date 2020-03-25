//
//  Constants.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/25/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation


struct URLs {
    static let BaseUrl = "https://api.flickr.com"
    static let Path = "services/rest"
}

struct ApiValue {
    static let ApiKey = "f9cc014fa76b098f9e82f1c288379ea1"
}

struct ParameterKeys {
    static let method = "method"
    static let api_key = "api_key"
    static let tags = "tags"
    static let page = "page"
    static let format = "format"
    static let json = "json"
    static let nojsoncallback = "nojsoncallback"
    static let methodSearch = "flickr.photos.search"
    static let methodSizes = "flickr.photos.getSizes"
    static let photo_id = "photo_id"
    static let tagKitten = "kitten"
}
