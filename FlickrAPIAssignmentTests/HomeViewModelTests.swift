//
//  HomeViewModelTests.swift
//  FlickrAPIAssignmentUITests
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
import Foundation
@testable import FlickrAPIAssignment

struct MockPhotoResponseModel {
    struct PhotoResponseModel: Codable {
        let photos: Photos
        let stat: String
    }
    struct Photos: Codable {
        let page, pages, perpage: Int
        let total: String
        let photo: [Photo]
    }
    struct Photo: Codable {
        let id, owner, secret, server: String
        let farm: Int
        let title: String
        let ispublic, isfriend, isfamily: Int
    }
}

class HomeViewModelTests: XCTestCase {
    var photoViewModel: MockPhotoResponseModel.PhotoResponseModel?
   
    override func setUp() {
    }

    override func tearDown() {
        photoViewModel = nil
    }
    
    func testViewModelIntialisation() {
        let json: [String: Any] = [
            "photos": [
                "page": 1,
                "pages":1581,
                "perpage":100,
                "total":"158062",
                "photo": [
                    [
                        "id":"47860199492",
                        "owner":"58679537@N00",
                        "secret":"4170ec35c9",
                        "server":"65535",
                        "farm":66,
                        "title":"The kitten on this book looks quite like Magic!",
                        "ispublic":1,
                        "isfriend":0,
                        "isfamily":0
                    ],
                ]
            ],
            "stat":"ok"
        ]
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: [])
            photoViewModel = try JSONDecoder().decode(MockPhotoResponseModel.PhotoResponseModel.self, from: data!)
        } catch {
            XCTFail("Fail to decode the model")
        }
        XCTAssertTrue(photoViewModel != nil, "Succesfully initialise the model")
    }
}
