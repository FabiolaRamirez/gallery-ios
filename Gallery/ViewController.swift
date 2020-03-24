//
//  ViewController.swift
//  Gallery
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getList()
        getSizes()
    }

    func getList() {
        Service.sharedInstance.fetchPhotos(success: {(photoResponse: [Photo]) in
            print("photosList: \(photoResponse)")
        }, failure: {(messaje: ErrorMessage) in
            print("error: \(messaje)")
        })
    }
    
    func getSizes() {
        Service.sharedInstance.getSizes(photoId: "31456463045", success: {(response: SizesResponse) in
               print("sizes response: \(response)")
           }, failure: {(messaje: ErrorMessage) in
               print("error: \(messaje)")
           })
       }

}

