//
//  GalleryPresenter.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/24/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation

protocol GalleryPresenterDelegate {
    func fetchPhotos()
    func getSizes(_ row: Int, cell: PhotoCollectionViewCell, photos: [Photo])
}

protocol GalleryProtocol: AnyObject {
    func successfulFetchPhotos(photos: [Photo])
    func failureFetchPhotos(message: String)
    func updateUIWhenTaskstarts()
}

struct GalleryPresenter: GalleryPresenterDelegate {
    
    weak var view: GalleryProtocol?
    
    init(view: GalleryProtocol) {
        self.view = view
    }
    
    func fetchPhotos() {
        view?.updateUIWhenTaskstarts()
        Service.sharedInstance.fetchPhotos(success: {(response: [Photo]) in
            self.view?.successfulFetchPhotos(photos: response)
        }, failure: {(error: ErrorMessage) in
            self.view?.failureFetchPhotos(message: error.message)
        })
    }
    
    func getSizes(_ row: Int, cell: PhotoCollectionViewCell, photos: [Photo]) {
        var photo = photos[row]
        Service.sharedInstance.getSizes(photoId: photo.id!, success: {(response) in
            photo.sizes = response
            cell.initWithData(photo)
        }, failure: {(error: ErrorMessage) in
            cell.initWithData(photo)
        })
    }
    
}

