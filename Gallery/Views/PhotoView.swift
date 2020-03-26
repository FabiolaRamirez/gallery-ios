//
//  PhotoView.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/26/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PhotoView: UIView {
    
    var view: UIView!
    
    var photoImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        view = UIView.loadNib("PhotoView", owner: self)
        view.frame = frame
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photoImageView = view.imageViewWithTag(10)
    }
    
    
}
