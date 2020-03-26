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
    
    static var shared = Service()
    
    let baseURL = URL(string: URLs.BaseUrl)!
    var photos: [Photo] = []
    var page: Int = 1
    var query: String?
    
    func fetchPhotos(success: @escaping(_ photos: [Photo]) -> (), failure: @escaping(_ errorResponse: ErrorMessage)-> ()){
    
        var photosURL = baseURL.appendingPathComponent(URLs.Path)
        
        let query: [String: String] = [
            ParameterKeys.method: ParameterKeys.methodSearch,
            ParameterKeys.api_key: ApiValue.ApiKey,
            ParameterKeys.tags:  Service.shared.query ?? ParameterKeys.tagKitten,
            ParameterKeys.page: String(Service.shared.page),
            ParameterKeys.format: ParameterKeys.json,
            ParameterKeys.nojsoncallback: "1"
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
        
        
        var sizesURL = baseURL.appendingPathComponent(URLs.Path)
        
        let query: [String: String] = [
            ParameterKeys.method: ParameterKeys.methodSizes,
            ParameterKeys.api_key: ApiValue.ApiKey,
            ParameterKeys.photo_id: "\(photoId)",
            ParameterKeys.format: ParameterKeys.json,
            ParameterKeys.nojsoncallback: "1"
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
