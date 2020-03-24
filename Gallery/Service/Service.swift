//
//  Service.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation
import UIKit


struct Service {
    
    static let sharedInstance = Service()
    
    let baseURL = URL(string: "https://api.flickr.com")!
    
    func fetchPhotos(success: @escaping(_ photoList: PhotosResponse) -> (), failure: @escaping(_ errorResponse: ErrorMessage)-> ()){
        
        
        var photosURL = baseURL.appendingPathComponent("services/rest")
        
        let query: [String: String] = [
            "method": "flickr.photos.search",
            "api_key": "f9cc014fa76b098f9e82f1c288379ea1",
            "tags": "kitten",
            "page": "1",
            "format": "json",
            "nojsoncallback": "1"
        ]
        
        photosURL = photosURL.withQueries(query)!
        
        print(photosURL.absoluteString)
        
        let task = URLSession.shared.dataTask(with: photosURL) { (data, response, error) in
            
            let jsonDecoder = JSONDecoder()
            
            guard (error == nil) else {
                failure(.noConnection)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                failure(.statusCode)
                return
            }
            
            if let data = data, let cards = try? jsonDecoder.decode(PhotosResponse.self, from: data) {
                success(cards)
            }
            
        }
        
        task.resume()
        
    }
    
}

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}
