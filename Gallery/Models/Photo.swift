//
//  Photo.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation


struct PhotosResponse: Decodable {
    var photos: PhotoResponse?
}

struct PhotoResponse: Decodable {
    var photo : [Photo]?
}

struct Photo: Decodable {
    var title: String?
    var ispublic: String?
    var isfriend: String?
    var isfamily: String?
}
