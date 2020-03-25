//
//  UIViewController+Gallery.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/25/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok".localized, style: .cancel) { (action) in
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}
