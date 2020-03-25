//
//  SearchPhotoViewController.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/24/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "photoCellId"
    var photos: [Photo] = []
    var galleryPresenter: GalleryPresenterDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCells()
        setupCollectionViewItenSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }
    
    func fetchPhotos() {
        galleryPresenter?.fetchPhotos()
    }
    
    func getSizes(_ row: Int, cell: PhotoCollectionViewCell) {
        galleryPresenter?.getSizes(row, cell: cell, photos: self.photos)
    }
    
    func setup() {
        self.navigationItem.title = "Gallery".localized
        self.galleryPresenter = GalleryPresenter(view: self)
    }
    
    func setupCells() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupCollectionViewItenSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 2
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = width + 30
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionViewFlowLayout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 50)
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }

}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("++++++++++++++++ \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.initWithData(photo)
        getSizes(indexPath.row, cell: cell)
        return cell
    }
    
}

extension GalleryViewController: GalleryProtocol {
    
    func successfulFetchPhotos(photos: [Photo]) {
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.photos = photos
        self.collectionView.reloadData()
        }
    }
    
    func failureFetchPhotos(message: String) {
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
            print("wwwwwww: \(message)")
            self.showSimpleAlert(title: "", message: message)
        }
    }
    
    func updateUIWhenTaskstarts() {
        self.activityIndicator.startAnimating()
    }
    
}
