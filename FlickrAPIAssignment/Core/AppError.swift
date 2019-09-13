//
//  AppError.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 03/08/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case networkError
    case fetchError
    case decodeError
    
    var errorMessage: String {
        switch self {
        case .networkError: return "Something went wrong!"
        case .fetchError: return "Unable to Fetch!"
        case .decodeError: return "Unable to decode the response"
        }
    }
}
