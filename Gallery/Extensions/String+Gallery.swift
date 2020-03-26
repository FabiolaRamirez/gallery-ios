//
//  String+Gallery.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/25/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
