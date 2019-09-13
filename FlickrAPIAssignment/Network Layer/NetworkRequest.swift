//
//  NetworkRequest.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 03/08/19.
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
                DispatchQueue.main.async {
                    completion(.failure(.fetchError))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
