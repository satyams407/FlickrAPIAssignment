//
//  NetworkLayerTest.swift
//  FlickrAPIAssignmentTests
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import FlickrAPIAssignment

class MockFetchPhotoService: FetchPhotoServiceProtocol {
    var responseJSONString: [String: Any]?
    func fetchPhotos(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<PhotoResponseModel, APIServiceError>) -> Void) {
        guard let responseString = responseJSONString, let data = try? JSONSerialization.data(withJSONObject: responseString, options: []) else {
            completionHandler(.failure(.fetchError))
            return
        }
        guard let responseModel = try? JSONDecoder().decode(PhotoResponseModel.self, from: data) else {
            completionHandler(.failure(.decodeError))
            return
        }
        completionHandler(.success(responseModel))
    }
}

class NetworkLayerTest: XCTestCase {
    var mockFetchPhotoService: MockFetchPhotoService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockFetchPhotoService = MockFetchPhotoService()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockFetchPhotoService = nil
    }
    
    func testFetchPhotoServiceSuccess() {
        mockFetchPhotoService?.responseJSONString =  [
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
        mockFetchPhotoService?.fetchPhotos(with: .fetchPhotos(searchText: "random", pageNumber: 1), completionHandler: {
            (result) in
            var isNetWorkResultSuccess = false
            switch result {
            case .success(_):
                isNetWorkResultSuccess = true
            case .failure(_):
                isNetWorkResultSuccess = false
            }
            XCTAssert(isNetWorkResultSuccess == true , "Failed")
        })
    }

    func testFetchPhotoServiceFailure() {
        mockFetchPhotoService?.responseJSONString = nil
        mockFetchPhotoService?.fetchPhotos(with: .fetchPhotos(searchText: "random", pageNumber: 1)) { (result) in
            var networkFailureError : APIServiceError?
            switch result {
            case .success(_):
                networkFailureError = nil
            case .failure(let error):
                networkFailureError = error
            }
            XCTAssert(networkFailureError == APIServiceError.fetchError , "Failed")
        }
    }
    
    func testEncoding() {
        guard let url = URL(string: "https://api.flickr.com/services/rest/") else {
            XCTFail("cannot convert the string into url")
            return
        }
        
        let parameters: [String: Any] = [
                           KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
                           KeyConstants.FetchPhotos.api_key.rawValue: "3e7cc266ae2b0e0d78e279ce8e361736",
                           KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
                           KeyConstants.FetchPhotos.format.rawValue: "json",
                           KeyConstants.FetchPhotos.safe_search.rawValue: 1,
                           KeyConstants.FetchPhotos.text.rawValue: "kittens"]
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            XCTFail("URl Components not made")
            return
        }
        guard let _ = URLRequest.init(url: url).url else {
            XCTFail("Request URl request not made")
            return
        }
        components.queryItems = [URLQueryItem]()
        for (key,value) in parameters {
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            components.queryItems?.append(queryItem)
        }
        let expectedURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=kittens"
        
        XCTAssertEqual(expectedURL.sorted(), components.url?.absoluteString.sorted(), "Not able to build the url")
    }

}
