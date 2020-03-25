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
    
    func fetchPhotos(success: @escaping(_ photos: [Photo]) -> (), failure: @escaping(_ errorResponse: ErrorMessage)-> ()){
        
        
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
            
            guard let data = data else {
                failure(.noFound)
                return
            }
            
            guard let response = try? jsonDecoder.decode(PhotosResponse.self, from: data) else {
                failure(.unableToParse)
                return
            }
            
            success(response.photos?.photo ?? [])
            
            
        }
        
        task.resume()
        
    }
    
    func getSizes(photoId: String, success: @escaping(_ sizes: SizesResponse) -> (), failure: @escaping(_ errorResponse: ErrorMessage)-> ()){
        
        
        var sizesURL = baseURL.appendingPathComponent("services/rest")
        
        let query: [String: String] = [
            "method": "flickr.photos.getSizes",
            "api_key": "f9cc014fa76b098f9e82f1c288379ea1",
            "photo_id": "\(photoId)",
            "format": "json",
            "nojsoncallback": "1"
        ]
        
        sizesURL = sizesURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: sizesURL) { (data, response, error) in
            
            let jsonDecoder = JSONDecoder()
            
            guard (error == nil) else {
                failure(.noConnection)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                failure(.statusCode)
                return
            }
            
            guard let data = data else {
                failure(.noFound)
                return
            }
            
            guard let response = try? jsonDecoder.decode(SizesResponse.self, from: data) else {
                failure(.unableToParse)
                return
            }
            DispatchQueue.main.async {
                success(response)
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
