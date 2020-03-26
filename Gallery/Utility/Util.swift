//
//  Util.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation

enum ErrorMessage: Int {
    case noConnection
    case statusCode
    case noFound
    case unableToParse
    case unableToConvert
    case noKeyFound
    
    var message: String {
        switch self {
        case .noConnection:
            return "NoConnectionError".localized
        case .statusCode:
            return "StatusCodeError".localized
        case .noFound:
            return "NoFoundError".localized
        case .unableToParse:
            return "UnableToParse".localized
        case .unableToConvert:
            return "UnableToConvert".localized
        case .noKeyFound:
            return "NoKeyFound".localized
        }
    }
}
