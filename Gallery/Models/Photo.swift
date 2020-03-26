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
    var id: String?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
    var sizes: SizesResponse?
}

struct SizesResponse: Decodable {
    var sizes: SizeResponse?
}

struct SizeResponse: Decodable {
    var size: [ExtraData]?
}

struct ExtraData: Decodable {
    var label: String?
    var source: String?
}
