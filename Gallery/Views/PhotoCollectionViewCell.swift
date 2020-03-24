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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initWithData(_ photo: Photo) {
        titleLabel.text = "title"
        //if let url = photo.source {
            photoImageView.sd_setImage(with: URL(string: "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_q.jpg"), placeholderImage: UIImage(named: "notFound"))
        //}
    }
    
}
