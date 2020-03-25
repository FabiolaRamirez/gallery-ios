//
//  GalleryTests.swift
//  GalleryTests
//
//  Created by Fabiola Ramirez on 3/23/20.
//  Copyright © 2020 Fabiola Ramirez. All rights reserved.
//

import XCTest
@testable import Gallery

class GalleryTests: XCTestCase {
    
    let expectedId = "49694339973"
    let expectedTitle = "Spritz"
    let expectedIspublic = 1
    let expectedIsFriend = 0
    let expectedIsFamily = 0
    let expectedSizes = SizesResponse()
    
    var photoTest: Photo!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        photoTest = Photo(id: expectedId, title: expectedTitle, ispublic: expectedIspublic, isfriend: expectedIsFriend, isfamily: expectedIsFamily, sizes: expectedSizes)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSUT_InitializesId() {
        XCTAssertEqual(photoTest.id, expectedId)
    }
    
    func testSUT_InitializesTitle() {
        XCTAssertEqual(photoTest.title, expectedTitle)
    }
    
    func testSUT_InitializesIspublic() {
        XCTAssertEqual(photoTest.ispublic, expectedIspublic)
    }
    
    func testSUT_InitializesIsFriend() {
        XCTAssertEqual(photoTest.isfriend, expectedIsFriend)
    }
    
    func testSUT_InitializesIsFamily() {
        XCTAssertEqual(photoTest.isfamily, expectedIsFamily)
    }
    
    func testSUT_InitializesSizes() {
        XCTAssertNotNil(photoTest.sizes)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
