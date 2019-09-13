//
//  FetchPhotoServiceProtocol.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 03/08/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchPhotoServiceProtocol {
    func fetchPhotos(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<PhotoResponseModel,APIServiceError>) -> Void)
}

extension FetchPhotoServiceProtocol {
    func buildRequest(endPoint: FetchEndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        request.httpMethod = endPoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        endPoint.encode(request: &request, urlParameters: endPoint.urlParameters)
        return request
    }
}
