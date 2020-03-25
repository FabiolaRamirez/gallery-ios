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
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "photoCellId"
    var photos: [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        getList()
        setupCells()
        setupCollectionViewItenSize()
    }
    
    func getList() {
        Service.sharedInstance.fetchPhotos(success: {(response: [Photo]) in
            print("photosList: \(response)")
            DispatchQueue.main.async {
            self.photos = response
            self.collectionView.reloadData()
            }
        }, failure: {(messaje: ErrorMessage) in
            print("error: \(messaje)")
        })
    }
    
    func getSizes(_ row: Int, cell: PhotoCollectionViewCell) {
        var photo = self.photos[row]
        Service.sharedInstance.getSizes(photoId: photo.id!, success: {(response) in
            print("sizes response: \(response)")
            photo.sizes = response
            cell.initWithData(photo)
        }, failure: {(messaje: ErrorMessage) in
            print("error: \(messaje)")
            cell.initWithData(photo)
        })
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
