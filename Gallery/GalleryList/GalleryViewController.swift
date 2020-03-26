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
    var galleryPresenter: GalleryPresenterDelegate?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCells()
        fetchPhotos()
        setupCollectionViewItenSize()
    }
    
    func fetchPhotos() {
        isLoading = true
        galleryPresenter?.fetchPhotos()
    }
    
    func getSizes(_ row: Int, cell: PhotoCollectionViewCell) {
        galleryPresenter?.getSizes(row, cell: cell)
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
        return Service.shared.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("++++++++++++++++ \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = Service.shared.photos[indexPath.row]
        cell.initWithData(photo)
        getSizes(indexPath.row, cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = Service.shared.photos[indexPath.row]
        showPhotoDetail(photo: photo)
    }
    
    func showPhotoDetail(photo: Photo) {
        let vc: GalleryDetailViewController = UIViewController.instantiateViewController(storyBoard: "Gallery", identifier: "galleryDetailViewController") as! GalleryDetailViewController
        vc.photo = photo
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            print("load moree.................")
            Service.shared.page += 1
            isLoading = true
            galleryPresenter?.fetchPhotos()
        }
    }
}

extension GalleryViewController: GalleryProtocol {
    
    func successfulFetchPhotos(photos: [Photo]) {
        self.isLoading = false
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        Service.shared.photos += photos
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
