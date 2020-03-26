//
//  UIView+Gallery.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/26/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func loadNib(_ name: String) -> UIView {
        let headerView = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
        return headerView
    }
    
    class func loadNib(_ name: String, owner: Any?) -> UIView {
        let headerView = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil).first as! UIView
        return headerView
    }
    
    func imageViewWithTag(_ tag: Int) -> UIImageView?{
        return (self.viewWithTag(tag) as? UIImageView)
    }
    
}
