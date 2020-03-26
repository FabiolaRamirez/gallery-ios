//
//  PhotoCollectionViewCell.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/24/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initWithData(_ photo: Photo) {
        let size = photo.sizes?.sizes?.size?.filter({$0.label == "Large Square"})
        if let imageUrl = size?[0].source {
            photoImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "notFound"))
        } else {
            photoImageView.image = UIImage(named: "notFound")
        }
    }
    
}
