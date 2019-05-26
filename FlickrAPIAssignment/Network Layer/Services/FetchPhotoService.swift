//
//  FetchPhotoService.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct FetchPhotoService: FetchPhotoServiceProtocol {
    
    func fetchPhotos(with endPoint: FetchEndPoint, completionHandler:@escaping (Result<PhotoResponseModel,APIServiceError>) -> Void) {
        NetworkRequest.sharedInstance.executeRequest(buildRequest(endPoint: endPoint)) { result in
            switch result {
            case.failure(let apiError) :
                completionHandler(.failure(apiError))
            case .success(let data):
                if let photoResponseModel = try? JSONDecoder().decode(PhotoResponseModel.self, from: data) {
                    completionHandler(.success(photoResponseModel))
                } else {
                    completionHandler(.failure(.decodeError))
                }
            }
        }
    }
}
