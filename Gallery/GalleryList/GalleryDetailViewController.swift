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
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("photooo: \(photo)")
        let size = photo?.sizes?.sizes?.size?.filter({$0.label == "Large"})
        print("size: \(size)")
        if let imageUrl = size?[0].source {
            photoImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "notFound"))
        } else {
            photoImageView.image = UIImage(named: "notFound")
        }
        
        
    }
    
    
}
