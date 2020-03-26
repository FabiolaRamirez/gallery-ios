//
//  GalleryDetailViewController.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/25/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import UIKit
import SDWebImage


class GalleryDetailViewController: UIViewController {
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let photoView = PhotoView()
        view.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let size = photo?.sizes?.sizes?.size?.filter({$0.label == "Large"})
        if let imageUrl = size?[0].source {
            photoView.photoImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "notFound"))
        } else {
            photoView.photoImageView.image = UIImage(named: "notFound")
        }
        
    }
    
}
