//
//  NetworkRequest.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

class NetworkRequest {
    static let sharedInstance = NetworkRequest()
    private init() {}
    
    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, APIServiceError>) -> (Void)) {
        // Todo - Can Check for internet connection
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.fetchError))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
