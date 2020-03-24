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
        getSizes()
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
    
    func getSizes() {
        Service.sharedInstance.getSizes(photoId: "31456463045", success: {(response: SizesResponse) in
               print("sizes response: \(response)")
           }, failure: {(messaje: ErrorMessage) in
               print("error: \(messaje)")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        //var photo = Photo()
        let photo = photos[indexPath.row]
        cell.initWithData(photo)
        return cell
    }
    
    
    
    
}
