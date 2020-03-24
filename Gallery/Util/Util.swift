//
//  Util.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case noConnection = "Looks like you have an unstable network, please try again later"
    case statusCode = "Your Request Returned A Status Code Other Than 2.."
    case noFound = "No Data Was Returned By The Request!"
    case unableToParse = "Could not Parse The Data As JSON"
    case unableToConvert = "Can not convert as a Dictionary"
    case noKeyFound = "Cannot find Key Results In parsedResult"
}
